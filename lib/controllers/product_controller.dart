import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:appwrite/appwrite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uniswap/core/utils/credentials.dart';
import 'package:uniswap/core/utils/helpers/loaders.dart';
import 'package:uniswap/data/saved_data.dart';
import 'package:uniswap/models/transaction_model.dart';
import 'package:uniswap/models/category.dart';
import 'package:uniswap/models/product_model.dart';
import 'package:uniswap/models/sub_category.dart';
import 'package:uniswap/models/bid_model.dart';
import 'package:uniswap/models/wallet_model.dart';

class ProductController extends GetxController {
  final Databases _databases = Databases(Get.find<Client>());
  final Storage _storage = Storage(Get.find<Client>());

  // Reactive list to hold categories
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  RxList<SubCategoryModel> subcategories = <SubCategoryModel>[].obs;
  RxList<ProductModel> products = <ProductModel>[].obs; // Reactive list for products
  RxList<ProductModel> productsByCategory = <ProductModel>[].obs; // Reactive list for products
  // RxList<ProductModel> searchProductFilter = <ProductModel>[].obs; // Reactive list for products
  RxList<BidModel> userBids = <BidModel>[].obs;
  RxList<WalletModel> wallet = <WalletModel>[].obs;
  RxList<TransactionModel> transaction = <TransactionModel>[].obs;

  // Collection and database IDs from credentials
  final String categoryCollectionId = Credentials.categoryCollectionId;
  final String productCollectionId = Credentials.productCollectionId;
  final String databaseId = Credentials.databaseId;
  final String subCategoryCollectionId = Credentials.subcategoryCollectonId;
  final String userCollectionId = Credentials.usersCollectonId;
  final String transactionCollectionId = Credentials.transactionCollectionId;

  // Loading state
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories(); // Fetch categories when the controller is initialized
    fetchSubCategories();
    fetchProducts();
    final userId = SavedData.getUserId();
    fetchUserBids();
    // Execute both in parallel for efficiency
    // Future.wait([
    fetchWalletData(userId);
    fetchTransactionData(userId);
    // ]);
  }

  // Fetch categories from the database
  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;

      // Fetch documents from the category collection
      final response = await _databases.listDocuments(
        databaseId: databaseId,
        collectionId: categoryCollectionId,
      );

      // Map documents to CategoryModel and update the list
      categories.value = response.documents.map((doc) => CategoryModel.fromJson(doc.data)).toList();
    } catch (e) {
      print('Error fetching categories: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchSubCategories() async {
    isLoading.value = true;
    try {
      final response = await _databases.listDocuments(
        databaseId: databaseId,
        collectionId: subCategoryCollectionId,
      );
      subcategories.value = response.documents.map((doc) => SubCategoryModel.fromJson(doc.data)).toList();
    } catch (e) {
      print("Error fetching subcategories: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch all products or by category ID
  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      // Fetch documents from Appwrite database
      final response = await _databases.listDocuments(
        databaseId: databaseId,
        collectionId: productCollectionId,
        queries: [
          Query.orderDesc('\$createdAt')
        ],
      );
      // Map the fetched documents to ProductModel
      products.value = response.documents.map((doc) => ProductModel.fromJson(doc.data)).toList();
    } catch (e) {
      print('Error fetching products: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> saveData(String collectionId, Map<String, dynamic> data) async {
    try {
      await _databases.createDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        documentId: ID.unique(),
        data: data,
      );
    } catch (e) {
      print("Error saving data: $e");
      rethrow;
    }
  }

  Future<String?> uploadImage(String bucketId, XFile image) async {
    try {
      final fileUpload = await _storage.createFile(
        bucketId: bucketId,
        fileId: ID.unique(),
        file: InputFile.fromPath(path: image.path, filename: image.name),
      );
      return fileUpload.$id;
    } catch (e) {
      print("Error uploading image: $e");
      rethrow;
    }
  }

  Future<dynamic> uploadMultipleImage(bucketId, XFile image) async {
    try {
      final response = await _storage.createFile(
        bucketId: bucketId,
        fileId: ID.unique(),
        file: InputFile.fromPath(
          path: image.path,
          filename: image.name,
        ),
      );
      final fileId = response.$id;
      return fileId;
    } catch (e) {
      rethrow;
    }
  }

  Future<double?> getHighestBid(String productId) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: databaseId,
        collectionId: Credentials.bidCollectionId,
        queries: [
          Query.equal('productId', [productId]), // Filter by productId
          Query.orderDesc('amount'), // Order by amount in descending order
          Query.limit(1), // Limit to the highest bid
        ],
      );

      if (response.documents.isNotEmpty) {
        // Extract the amount and directly cast it to a double
        final int amountInt = response.documents.first.data['amount'];
        final double highestAmount = amountInt.toDouble(); // Convert int to double

        return highestAmount;
      }

      return null; // Return null if no bids are found for the product
    } catch (e) {
      print("Error fetching highest bid amount: $e");
      return null;
    }
  }

  Future<int> getNumberOfBidders(String productId) async {
    try {
      // Fetch all bids for the specific product
      final response = await _databases.listDocuments(
        databaseId: databaseId,
        collectionId: Credentials.bidCollectionId,
        queries: [
          Query.equal('productId', [productId]), // Filter by productId
        ],
      );

      // Extract unique userIds from the bids
      final uniqueUserIds = response.documents.map((doc) => doc.data['userId']).toSet();

      // Return the count of unique userIds
      return uniqueUserIds.length;
    } catch (e) {
      print("Error fetching number of bidders: $e");
      return 0; // Return 0 if there's an error
    }
  }

  Future<void> saveOrUpdateBid(String productId, BidModel bid) async {
    try {
      // Fetch all bids for the product
      final response = await _databases.listDocuments(
        databaseId: databaseId,
        collectionId: Credentials.bidCollectionId, // Replace with your bid collection ID
        queries: [
          Query.equal('userId', [bid.userId]), // Filter bids by userId
          Query.equal('productId', [productId]), // Filter bids by productId
        ],
      );

      if (response.documents.isNotEmpty) {
        // If the user already has a bid, update it
        final existingBidId = response.documents.first.$id;
        await _databases.updateDocument(
          databaseId: databaseId,
          collectionId: Credentials.bidCollectionId,
          documentId: existingBidId,
          // data: bid.toJson(),
          data: {
            'amount': bid.amount,
          },
        );
      } else {
        // If the user doesn't have a bid, create a new one
        await _databases.createDocument(
          databaseId: databaseId,
          collectionId: Credentials.bidCollectionId,
          documentId: ID.unique(),
          data: {
            ...bid.toJson(),
            'productId': productId, // Associate the bid with the product
          },
        );
      }
    } catch (e) {
      print("Error saving or updating bid: $e");
      rethrow;
    }
  }

// Delete a bid
  Future<void> deleteBid(String docID) async {
    try {
      EasyLoading.show(status: 'Deleting...');
      await _databases.deleteDocument(
        databaseId: databaseId,
        collectionId: Credentials.bidCollectionId,
        documentId: docID,
      );
      userBids.removeWhere((bid) => bid.docId == docID); // Remove the bid from the list
      EasyLoading.dismiss();
      TLoaders.successSnackBar(title: "Success", message: "Bid deleted successfully");
    } catch (e) {
      EasyLoading.dismiss();
      TLoaders.errorSnackBar(title: "Error", message: "Error deleting bid: $e");
      print('Error deleting bid: $e');
    }
  }

  
  // Fetch current user bids
  Future<void> fetchUserBids() async {
    try {
      final userId = SavedData.getUserId();
      final response = await _databases.listDocuments(
        databaseId: databaseId,
        collectionId: Credentials.bidCollectionId,
        queries: [
          Query.equal('userId', [userId]), // Filter by userId
        ],
      );

      List<BidModel> fetchedBids = response.documents.map((doc) {
        return BidModel.fromJson(doc.data);
      }).toList();

      userBids.assignAll(fetchedBids);
    } catch (e) {
      print("Error fetching user bids: $e");
    }
  }

  Future<void> fetchProductsByCategory({String? categoryId}) async {
    try {
      isLoading(true);

      // Build query for fetching products
      List<String> queries = [];
      if (categoryId != null) {
        // Filter products by category ID
        queries.add(Query.equal('categoryId', categoryId));
      }

      // Fetch documents from Appwrite database
      final response = await _databases.listDocuments(
        databaseId: databaseId,
        collectionId: productCollectionId,
        queries: queries, // Apply queries if any
      );

      // Map the fetched documents to ProductModel
      productsByCategory.value = response.documents.map((doc) => ProductModel.fromJson(doc.data)).toList();
    } catch (e) {
      print('Error fetching products: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<List<ProductModel>> searchProducts(String query) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: databaseId,
        collectionId: productCollectionId,
        queries: [
          Query.search('productName', query), // Searching by product name
        ],
      );

      // Convert documents to ProductModel
      return response.documents.map((doc) => ProductModel.fromJson(doc.data)).toList();
    } catch (e) {
      print('Search Error: $e');
      return [];
    }
  }

  // Fetch current user wallet
  Future<void> fetchWalletData(String userId) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: Credentials.databaseId,
        collectionId: Credentials.walletCollectionId,
        queries: [
          Query.equal('userId', [userId]),
        ],
      );

      List<WalletModel> fetchedWallet = response.documents.map((doc) {
        return WalletModel.fromJson(doc.data);
      }).toList();

      wallet.assignAll(fetchedWallet); // Correctly updating the list
    } catch (e) {
      TLoaders.errorSnackBar(title: "Error", message: "Error fetching wallet: $e");
    }
  }

  // Future<void> fetchTransactionData(String userId) async {
  //   try {
  //     final response = await _databases.listDocuments(
  //       databaseId: Credentials.databaseId,
  //       collectionId: Credentials.transactionCollectionId,
  //       queries: [
  //         Query.equal('userId', [userId])
  //       ],
  //     );

  //     List<TransactionModel> fetchedTransactions = response.documents.map((doc) {
  //       return TransactionModel.fromJson(doc.data);
  //     }).toList();

  //     transaction.assignAll(fetchedTransactions);
  //   } catch (e) {
  //     TLoaders.errorSnackBar(title: "Error", message: "Error fetching transactions: $e");
  //   }
  // }
  Future<void> fetchTransactionData(String userId) async {
    try {
      isLoading(true);

      final response = await _databases.listDocuments(
        databaseId: Credentials.databaseId,
        collectionId: Credentials.transactionCollectionId,
        queries: [
          Query.or([
            Query.equal('buyerId', userId), // Transactions where user is buyer
            Query.equal('sellerId', userId), // Transactions where user is seller
            Query.equal('userId', userId),
          ]),
         Query.orderDesc('\$createdAt')
        ],
      );

      List<TransactionModel> fetchedTransactions = response.documents.map((doc) {
        return TransactionModel.fromJson(doc.data);
      }).toList();

      transaction.assignAll(fetchedTransactions);
    } catch (e) {
      TLoaders.errorSnackBar(title: "Error", message: "Error fetching transactions: $e");
    } finally {
      isLoading(false);
    }
  }

}

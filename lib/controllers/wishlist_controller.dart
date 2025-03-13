import 'package:appwrite/appwrite.dart';
import 'package:get/get.dart';
import 'package:uniswap/core/utils/credentials.dart';
import 'package:uniswap/core/utils/helpers/loaders.dart';
import 'package:uniswap/data/saved_data.dart';
import 'package:uniswap/models/product_model.dart';
import 'package:flutter/material.dart';

class WishController extends GetxController {
  // ... existing code ...

  // Add these new properties
  RxList<ProductModel> wishlistProducts = <ProductModel>[].obs;
  final String wishlistCollectionId = Credentials.wishlistCollectionId; // Add this to Credentials
  final String productCollectionId = Credentials.productCollectionId;
  final String databaseId = Credentials.databaseId;
  final Databases _databases = Databases(Get.find<Client>());
// Loading state
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    // Add this to initial load
    fetchWishlist();
  }

  // Add these new methods

  // Fetch user's wishlist products
  Future<void> fetchWishlist() async {
    try {
      isLoading(true);
      final userId = SavedData.getUserId();
      
      // 1. Get all wishlist documents for current user
      final wishlistResponse = await _databases.listDocuments(
        databaseId: databaseId,
        collectionId: wishlistCollectionId,
        queries: [Query.equal('userId', [userId])],
      );

      // 2. Extract item IDs from wishlist
      final itemIds = wishlistResponse.documents
          .map((doc) => doc.data['itemId'] as String)
          .toList();

      if (itemIds.isEmpty) {
        wishlistProducts.clear();
        return;
      }

      // 3. Fetch products that match the wishlist item IDs
      final productsResponse = await _databases.listDocuments(
        databaseId: databaseId,
        collectionId: productCollectionId,
        queries: [Query.equal('\$id', itemIds)],
      );

      // 4. Update wishlist products
      wishlistProducts.value = productsResponse.documents
          .map((doc) => ProductModel.fromJson(doc.data))
          .toList();

    } catch (e) {
      // print('Error fetching wishlist: $e');
      TLoaders.errorSnackBar(title: 'Error', message: 'Failed to load wishlist');
    } finally {
      isLoading(false);
    }
  }

  // Add item to wishlist
  Future<void> addToWishlist(String itemId) async {
    try {
      final userId = SavedData.getUserId();
      await _databases.createDocument(
        databaseId: databaseId,
        collectionId: wishlistCollectionId,
        documentId: ID.unique(),
        data: {
          'userId': userId,
          'itemId': itemId,
          'timestamp': DateTime.now().toIso8601String(),
        },
      );
      
      // Refresh wishlist after adding
      await fetchWishlist();
      // TLoaders.successSnackBar(title: 'Success', message: 'Added to wishlist');
      TLoaders.toaster(bgColor: Colors.green, msg: 'Added to wishlist');

    } catch (e) {
      // print('Error adding to wishlist: $e');
      // TLoaders.errorSnackBar(title: 'Error', message: 'Failed to add to wishlist');
      TLoaders.toaster(bgColor: Colors.red, msg: 'Failed to add from wishlist');
    }
  }

  // Remove item from wishlist
  Future<void> removeFromWishlist(String itemId) async {
    try {
      final userId = SavedData.getUserId();
      
      // Find the wishlist document
      final response = await _databases.listDocuments(
        databaseId: databaseId,
        collectionId: wishlistCollectionId,
        queries: [
          Query.equal('userId', [userId]),
          Query.equal('itemId', [itemId]),
        ],
      );

      if (response.documents.isNotEmpty) {
        await _databases.deleteDocument(
          databaseId: databaseId,
          collectionId: wishlistCollectionId,
          documentId: response.documents.first.$id,
        );
      }

      // Refresh wishlist after removal
      await fetchWishlist();
      // TLoaders.successSnackBar(title: 'Success', message: 'Removed from wishlist');
      TLoaders.toaster(bgColor: Colors.red, msg: 'Removed from wishlist');

    } catch (e) {
      // print('Error removing from wishlist: $e');
      TLoaders.toaster(bgColor: Colors.red, msg: 'Failed to remove from wishlist');
    }
  }

  // Check if item is in wishlist
  bool isInWishlist(String itemId) {
    return wishlistProducts.any((product) => product.docId == itemId);
  }

  // Toggle wishlist status
  Future<void> toggleWishlist(String itemId) async {
    if (isInWishlist(itemId)) {
      await removeFromWishlist(itemId);
    } else {
      await addToWishlist(itemId);
    }
  }
}
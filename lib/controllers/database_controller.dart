import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uniswap/core/utils/credentials.dart';
import 'package:uniswap/core/utils/exceptions/appwrite_exceptions.dart';
import 'package:uniswap/core/utils/exceptions/format_exceptions.dart';
import 'package:uniswap/core/utils/exceptions/platform_exceptions.dart';
import 'package:uniswap/core/utils/helpers/loaders.dart';
import 'package:uniswap/data/saved_data.dart';
import 'package:uniswap/models/transaction_model.dart';
import 'package:uniswap/models/user.dart';
import 'package:uniswap/models/wallet_model.dart';

class DatabaseController extends GetxController {
  static DatabaseController get instance => Get.find();

  final Account account = Account(Get.find<Client>()); // Use Get.find<Client>()
  final Databases databases = Databases(Get.find<Client>()); // Use Get.find<Client>()
  final Storage storage = Storage(Get.find<Client>());
  final Realtime realtime = Realtime(Get.find<Client>());

  final String databaseId = Credentials.databaseId; // Replace with your Database ID
  final String userCollectionId = Credentials.usersCollectonId; // Replace with your Collection ID
  final String identityCollectionId = Credentials.identificationCollectionId; // Replace with your Collection ID
  final String walletCollectionId = Credentials.walletCollectionId; // Replace with your Collection ID
  final String transactionCollectionId = Credentials.transactionCollectionId; // Replace with your Collection ID
  final String chatCollectionId = Credentials.chatCollectionId; // Replace with your Collection ID

  final RxList<Document> ratings = <Document>[].obs;
  final RxList<Document> allRatings = <Document>[].obs;
  final RxDouble overallRating = 0.0.obs;
  final RxMap<String, double> ratingProgress = <String, double>{}.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   final userId = Get.arguments['userId'];
  //   // final userId = data!.userId;
  //   if (userId != null) {
  //     fetchRatings(userId); // Pass userId to fetchRatings
  //     fetchRatings2(userId); // Pass userId to fetchRatings
  //   } else {
  //     print('UserId is null. Cannot fetch ratings.');
  //   }
  // }

  Stream<RealtimeMessage> subscribeToChat() {
    return realtime.subscribe(['databases.$databaseId.collections.$chatCollectionId.documents']).stream;
  }

  // Stream<RealtimeMessage> subscribeToChat(String userId, String receiverId) {
  //   return realtime.subscribe(['databases.$databaseId.collections.$chatCollectionId.documents']).stream;
  // }

  Future<void> saveUserRecord(UserModel user) async {
    try {
      await databases.createDocument(
        databaseId: databaseId,
        collectionId: userCollectionId,
        documentId: user.userId.toString(),
        data: user.toJson(),
      );
    } on AppwriteException catch (e) {
      throw TAppwriteException(e.message.toString()).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (_) {
      throw 'An unexpected error occurred. Please try again.';
    }
  }

  // Create userWallet during registration
  // Future<void> createUserWallet(WalletModel wallet) async {
  //   try {
  //     await databases.createDocument(
  //       databaseId: databaseId,
  //       collectionId: walletCollectionId,
  //       documentId: wallet.userId.toString(),
  //       data: wallet.toJson(),
  //     );
  //   } on AppwriteException catch (e) {
  //     throw TAppwriteException(e.message.toString()).message;
  //   } on FormatException {
  //     throw const TFormatException();
  //   } on PlatformException catch (e) {
  //     throw TPlatformException(e.code).message;
  //   } catch (_) {
  //     throw 'An unexpected error occurred. Please try again.';
  //   }
  // }

  Future<void> createUserWallet(WalletModel wallet) async {
    try {
      await databases.createDocument(
        databaseId: databaseId,
        collectionId: walletCollectionId,
        documentId: wallet.docId, // Use the docId from model
        data: wallet.toJson(),
      );
    } on AppwriteException catch (e) {
      if (e.code == 409) {
        // Document already exists
        Get.log('Wallet already exists for user ${wallet.userId}');
        return;
      }
      throw TAppwriteException(e.message.toString()).message;
    } catch (e) {
      throw 'Failed to create wallet: ${e.toString()}';
    }
  }

  Future<void> getUserData() async {
    final id = SavedData.getUserId();
    print(id);
    try {
      final data = await databases.listDocuments(
        databaseId: databaseId,
        collectionId: userCollectionId,
        queries: [
          Query.equal("userId", id),
        ],
      );

      // Convert the document data to a map
      final userData = data.documents[0].data;

      // Save the entire user data as a map
      await SavedData.saveUserData(userData);

      print("User data saved: $userData");
    } on AppwriteException catch (e) {
      throw TAppwriteException(e.message.toString()).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (_) {
      throw 'An unexpected error occurred. Please try again.';
    }
  }

  // Update user details
  Future<void> updateUserDetails(Map<String, dynamic> data) async {
    try {
      // UserModel user = SavedData.getUser();
      final userId = SavedData.getUserId();
      // String userId = user.userId.toString();
      if (userId.isEmpty) throw 'User ID not found';
      await databases.updateDocument(
        databaseId: databaseId,
        collectionId: userCollectionId,
        documentId: userId,
        data: data,
      );
    } on AppwriteException catch (e) {
      throw TAppwriteException(e.message.toString()).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (_) {
      throw 'An unexpected error occurred. Please try again.';
    }
  }

  // Upload image to database
  Future<dynamic> uploadImage(bucketId, XFile image) async {
    final userId = SavedData.getUserId();
    if (userId.isEmpty) throw 'User ID not found';
    try {
      final fileUpload = await storage.createFile(
        bucketId: bucketId,
        fileId: ID.unique(),
        file: InputFile.fromPath(
          path: image.path,
          filename: image.name,
        ),
      );

      final fileId = fileUpload.$id;
      return fileId;
    } on AppwriteException catch (e) {
      throw TAppwriteException(e.message.toString()).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (_) {
      throw 'An unexpected error occurred. Please try again.';
    }
  }

  // Save user NIN and BVN during registration
  Future<void> saveUserIdentity(Map<String, dynamic> data) async {
    final userId = SavedData.getUserId();
    if (userId.isEmpty) throw 'User ID not found';
    try {
      await databases.createDocument(
        databaseId: databaseId,
        collectionId: identityCollectionId,
        documentId: userId,
        data: data,
      );
    } on AppwriteException catch (e) {
      throw TAppwriteException(e.message.toString()).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (_) {
      throw 'An unexpected error occurred. Please try again.';
    }
  }

  // Update any details in database
  Future<void> updateData(Map<String, dynamic> data, collection, documentId) async {
    try {
      final userId = SavedData.getUserId();
      // String userId = user.userId.toString();
      if (userId.isEmpty) throw 'User ID not found';
      await databases.updateDocument(
        databaseId: databaseId,
        collectionId: collection,
        documentId: documentId,
        data: data,
      );
    } on AppwriteException catch (e) {
      TLoaders.errorSnackBar(title: 'Error', message: e.message.toString());
      print(e.message.toString());
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (_) {
      throw 'An unexpected error occurred. Please try again.';
    }
  }

  // Save user transactions to database
  Future<void> createUserTransactions(TransactionModel transaction) async {
    try {
      await databases.createDocument(
        databaseId: databaseId,
        collectionId: transactionCollectionId,
        documentId: transaction.userId.toString(),
        data: transaction.toJson(),
      );
    } on AppwriteException catch (e) {
      TLoaders.errorSnackBar(title: 'Error', message: e.message.toString());
      // throw TAppwriteException(e.message.toString()).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (_) {
      throw 'An unexpected error occurred. Please try again.';
    }
  }

  // Chat Method

  // Future<void> sendMessage(String senderId, String receiverId, String message) async {
  //   try {
  //     await databases.createDocument(
  //       databaseId: databaseId,
  //       collectionId: chatCollectionId,
  //       documentId: 'unique()', // Auto-generate document ID
  //       data: {
  //         'senderId': senderId,
  //         'receiverId': receiverId,
  //         'message': message,
  //         'timestamp': DateTime.now().toIso8601String(),
  //       },
  //     );
  //   } catch (e) {
  //     print('Error sending message: $e');
  //   }
  // }

  // Future<List<Document>> getMessages(String userId1, String userId2) async {
  //   try {
  //     final response = await databases.listDocuments(databaseId: databaseId, collectionId: chatCollectionId, queries: [
  //       // Query.or([Query.equal("senderId", userId1),
  //       // Query.equal("receiverId", userId2)]),
  //        Query.or([Query.equal("senderId", userId1), Query.equal("receiverId", userId2)]),
  //       Query.orderAsc("timestamp"),
  //       Query.limit(2000),
  //     ]);
  //     return response.documents;
  //   } catch (e) {
  //     print('Error fetching messages: $e');
  //     return [];
  //   }
  // }

  // Future<List<Document>> getAllChats() async {
  //   try {
  //     final userId = SavedData.getUserId();
  //     final response = await databases.listDocuments(
  //       databaseId: databaseId,
  //       collectionId: chatCollectionId,
  //       queries: [
  //         // Query.equal('senderId', userId), // Chats where the user is the sender
  //         // Query.equal('receiverId', userId), // Chats where the user is the receiver
  //         Query.or([Query.equal("senderId", userId), Query.equal("receiverId", userId)]),
  //         Query.orderDesc("timestamp"),
  //         Query.limit(2000),
  //       ],
  //     );

  //     return response.documents;
  //   } catch (e) {
  //     print('Error fetching chats: $e');
  //     return [];
  //   }
  // }

  Future<void> submitRating({
    required String userId,
    required String raterId,
    required String name,
    required String photo,
    required String avatar,
    required double communicationRating,
    required double productQualityRating,
    required double easyGoingRating,
    required String comment,
  }) async {
    try {
      await databases.createDocument(
        databaseId: Credentials.databaseId,
        collectionId: Credentials.ratingsCollectionId,
        documentId: 'unique()',
        data: {
          'userId': userId,
          'raterId': raterId,
          'name': name,
          'photo': photo,
          'avatar': avatar,
          'communicationRating': communicationRating,
          'productQualityRating': productQualityRating,
          'easyGoingRating': easyGoingRating,
          'comment': comment,
          'timestamp': DateTime.now().toIso8601String(),
        },
      );
      await fetchRatings(userId);
    } catch (e) {
      print('Error submitting rating: $e');
    }
  }

  Future<void> fetchRatings(String userId) async {
    try {
      final response = await databases.listDocuments(
        databaseId: Credentials.databaseId,
        collectionId: Credentials.ratingsCollectionId,
        queries: [Query.equal('userId', userId)],
      );
      ratings.assignAll(response.documents);
      _calculateOverallRating();
    } catch (e) {
      print('Error fetching ratings: $e');
    }
  }

  void _calculateOverallRating() {
    if (ratings.isEmpty) {
      overallRating.value = 0.0;
      return;
    }

    double total = 0;
    for (final rating in ratings) {
      total += (rating.data['communicationRating'] + rating.data['productQualityRating'] + rating.data['easyGoingRating']) / 3;
    }
    overallRating.value = total / ratings.length;
  }

  Future<void> fetchRatings2(String userId) async {
    try {
      final response = await databases.listDocuments(
        databaseId: Credentials.databaseId,
        collectionId: Credentials.ratingsCollectionId,
        queries: [Query.equal('userId', userId)],
      );
      allRatings.assignAll(response.documents);
      _calculateRatingProgress();
      update();
    } catch (e) {
      print('Error fetching ratings: $e');
    }
  }

  void _calculateRatingProgress() {
    final Map<String, double> progress = {
      'communication': 0.0,
      'productQuality': 0.0,
      'easyGoing': 0.0,
    };

    if (allRatings.isEmpty) {
      ratingProgress.assignAll(progress);
      return;
    }

    for (final rating in allRatings) {
      progress['communication'] = (progress['communication'] ?? 0) + (rating.data['communicationRating'] ?? 0);
      progress['productQuality'] = (progress['productQuality'] ?? 0) + (rating.data['productQualityRating'] ?? 0);
      progress['easyGoing'] = (progress['easyGoing'] ?? 0) + (rating.data['easyGoingRating'] ?? 0);
    }

    progress['communication'] = (progress['communication'] ?? 0) / allRatings.length;
    progress['productQuality'] = (progress['productQuality'] ?? 0) / allRatings.length;
    progress['easyGoing'] = (progress['easyGoing'] ?? 0) / allRatings.length;

    ratingProgress.assignAll(progress);
  }
}

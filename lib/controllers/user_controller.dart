import 'package:appwrite/appwrite.dart';
import 'package:get/get.dart';
import 'package:uniswap/controllers/appwrite_controller.dart';
import 'package:uniswap/core/utils/credentials.dart';
import 'package:uniswap/data/saved_data.dart';
import 'package:uniswap/models/user.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  final AppwriteController appwriteController = Get.find();
  final Account account = Account(Get.find<Client>()); // Use Get.find<Client>()
  final Databases databases = Databases(Get.find<Client>()); // Use Get.find<Client>()
  final Storage storage = Storage(Get.find<Client>());
  final Realtime realtime = Realtime(Get.find<Client>());

  final String databaseId = Credentials.databaseId; // Replace with your Database ID
  final String userCollectionId = Credentials.usersCollectonId; // Replace with your Collection ID
  final String identityCollectionId = Credentials.identificationCollectionId; // Replace with your Collection ID
  final String walletCollectionId = Credentials.walletCollectionId; // Replace with your Collection ID
  final String transactionCollectionId = Credentials.transactionCollectionId; // Replace with your Collection ID
  final String chatCollectionId = Credentials.chatCollectionId;
  final String reportsCollectionId = Credentials.reportsCollectionId;
  var userId = RxString('');

  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchUserData();
  // }

  // Future<void> fetchUserData() async {
  //   final id = await appwriteController.getCurrentUserId();
  //   if (id != null) {
  //      try {
  //       final document = await databases.getDocument(
  //         databaseId: databaseId,
  //         collectionId: userCollectionId,
  //         documentId: id,
  //       );
  //       await SavedData.saveUserData(document.data);
  //       // return UserModel.fromJson(document.data);
  //       print("User data fetched successfully: ${document.data}");
  //     } catch (e) {
  //       print("Error fetching user by ID: $e");
  //       return null;
  //     }
  //   }
  // }

  // Get user by ID
  Future<UserModel?> getUserById(dynamic userId) async {
    try {
      final document = await databases.getDocument(
        databaseId: databaseId,
        collectionId: userCollectionId,
        documentId: userId,
      );
     
      return UserModel.fromJson(document.data);
    } catch (e) {
      print("Error fetching user by ID: $e");
      return null;
    }
  }
  // Future<UserModel?> getUserData(dynamic userId) async {
  //   try {
  //     final document = await databases.getDocument(
  //       databaseId: databaseId,
  //       collectionId: userCollectionId,
  //       documentId: userId,
  //     );
  //     await SavedData.saveUserData(document.data);
  //     return UserModel.fromJson(document.data);
  //   } catch (e) {
  //     print("Error fetching user by ID: $e");
  //     return null;
  //   }
  // }

  // Delete the user's account
  Future<void> deleteAccount() async {
    try {
      final userId = SavedData.getUserId();
      // Step 1: Delete the user's account from Appwrite
      await account.deleteIdentity(identityId: userId);

      // Step 2: (Optional) Delete the user's document from the database
      await databases.deleteDocument(
        databaseId: databaseId,
        collectionId: userCollectionId,
        documentId: userId,
      );
    } catch (e) {
      print("Error deleting account: $e");
      rethrow; // Rethrow the error to handle it in the UI
    }
  }

    // Submit a report
  Future<void> submitReport({
    required String email,
    required String report,
  }) async {
    try {
      // // Validate input
      // if (email.isEmpty || report.isEmpty) {
      //   throw Exception('Email and report cannot be empty');
      // }
      // Create a document in the reports collection
      await databases.createDocument(
        databaseId: databaseId,
        collectionId: reportsCollectionId,
        documentId: ID.unique(), // Generate a unique document ID
        data: {
          'email': email,
          'report': report,
          'timestamp': DateTime.now().toIso8601String(), // Add a timestamp
        },
      );
      
    } catch (e) {
      // Handle errors
      Get.snackbar('Error', 'Failed to submit report: $e');
      rethrow; // Rethrow the error to handle it in the UI
    }
  }

}

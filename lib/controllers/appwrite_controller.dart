import 'package:appwrite/appwrite.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uniswap/core/utils/credentials.dart';
import 'package:uniswap/core/utils/helpers/loaders.dart';
import 'package:uniswap/core/utils/helpers/network_manager.dart';
import 'package:uniswap/models/user.dart';

class AppwriteController extends GetxController {
  static AppwriteController get instance => Get.find();

    // Variables
  final box = GetStorage();
  final Client client = Client();
  late final Account account;
  late final Databases databases;
  late final Storage storage;
  late final Realtime realtime;

  /// Getter for the currently authenticated user
  var user = Rxn<UserModel>(); // Reactive user model (nullable)

  @override
  void onInit() {
    super.onInit();
    _initializeAppwrite();
    Get.put(client); // Register the Client with GetX
  }

  void _initializeAppwrite() {
    client
        .setEndpoint(Credentials.apiEndpoint) // Appwrite Endpoint
        .setProject(Credentials.projectID)
        .setSelfSigned(status: true); // Appwrite Project ID
    account = Account(client);
    databases = Databases(client);
    storage = Storage(client);
    realtime = Realtime(client);
  }

  //  /// Fetch the current user's ID
  // Future<String?> getCurrentUserId() async {
  //   try {
  //     final user = await account.get();
  //     return user.$id; // Return the current user's ID
  //   } catch (e) {
  //     print('Error fetching user: $e');
  //     return null;
  //   }
  // }

  final Connectivity _connectivity = Connectivity();

  Future<bool> _checkInternetConnection() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true; // Connected to the internet
    } else {
      return false; // No internet connection
    }
  }

  Future<String?> getCurrentUserId() async {
    if (!await NetworkManager.instance.isConnected()) {
    TLoaders.customToast(message: 'No internet connection');
    return null;
  }
  try {
    final userData = await account.get();
    user.value = UserModel.fromJson(userData.toMap()); // Update reactive user
    return userData.$id;
  } catch (e) {
    print('Error fetching user: $e');
    user.value = null; // Clear user data on error
    return null;
  }
}
}
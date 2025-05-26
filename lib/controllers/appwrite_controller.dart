import 'package:appwrite/appwrite.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uniswap/core/utils/credentials.dart';
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
  // var user = Rxn<UserModel>(); // Reactive user model (nullable)
  RxList<UserModel> user = <UserModel>[].obs;

  final String databaseId = Credentials.databaseId; // Replace with your Database ID
  final String userCollectionId = Credentials.usersCollectonId; // Replace with your Collection ID
  final String identityCollectionId = Credentials.identificationCollectionId; // Replace with your Collection ID
  final String walletCollectionId = Credentials.walletCollectionId; // Replace with your Collection ID
  final String transactionCollectionId = Credentials.transactionCollectionId; // Replace with your Collection ID
  final String chatCollectionId = Credentials.chatCollectionId;

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

  final Connectivity _connectivity = Connectivity();

  Future<bool> checkInternetConnection() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      return true; // Connected to the internet
    } else {
      return false; // No internet connection
    }
  }

}

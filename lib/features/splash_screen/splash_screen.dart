import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uniswap/controllers/appwrite_controller.dart';
import 'package:uniswap/controllers/auth_controller.dart';
import 'package:uniswap/core/utils/credentials.dart';
import 'package:uniswap/core/utils/helpers/network_manager.dart'; // Import NetworkManager
import 'package:uniswap/data/saved_data.dart';
import 'package:uniswap/features/authentication/screens/create_pin/create_pin_screen.dart';
import 'package:uniswap/features/authentication/screens/signup/sign_up_screen.dart';
import 'package:uniswap/features/home/screens/home_container/home_container.dart';
import 'package:uniswap/features/onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AppwriteController appwriteController = Get.find<AppwriteController>();
  final NetworkManager networkManager = Get.find<NetworkManager>(); // Inject NetworkManager
  final GetStorage box = GetStorage();
  final controller = Get.put(AuthController());
  final Account account = Account(Get.find<Client>());
  final Databases databases = Databases(Get.find<Client>());

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate a splash screen delay

    // Check internet connectivity
    if (!await networkManager.isConnected()) {
      // Show a persistent dialog for no internet connection
      _showNoInternetDialog();
      return;
    }

    // Proceed with app initialization
    final bool isFirstTime = box.read('isFirstTime') ?? true;
    if (isFirstTime) {
      box.write('isFirstTime', false);
      Get.offAll(() => const OnboardingScreen());
    } else {
      final userData = SavedData.getUserData();
      if (userData['userId'] == null) {
        Get.offAll(() => const SignUpScreen());
      } else {

        final bool isComplete = userData['basicProgress'] ?? false;
        // SavedData.saveUserData(userData.data);
        if (isComplete) {
          Get.offAll(() => const HomeContainer());
        } else {
          Get.offAll(() => const CreatePinScreen());
        }
      }
      
      // if (user.$id != null) {
      //   final userData = await databases.getDocument(
      //     databaseId: Credentials.databaseId,
      //     collectionId: Credentials.usersCollectonId,
      //     documentId: user.$id,
      //   );
      //   print("User data fetched successfully: ${userData.data}");
      //   await SavedData.saveUserData(userData.data);
      //   final bool isComplete = userData.data['basicProgress'] ?? false;
      //   // SavedData.saveUserData(userData.data);
      //   if (isComplete) {
      //     Get.offAll(() => const HomeContainer());
      //   } else {
      //     Get.offAll(() => const CreatePinScreen());
      //   }
      // } else {
      //   Get.offAll(() => const SignUpScreen());
      // }
    }
  }

  void _showNoInternetDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing the dialog by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('No Internet Connection'),
          content: const Text('Please check your internet connection and try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _initializeApp(); // Retry initialization
              },
              child: const Text('Retry'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/logo.png', // Replace with your logo path
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}

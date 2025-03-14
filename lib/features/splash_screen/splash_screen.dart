import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uniswap/controllers/appwrite_controller.dart';
import 'package:uniswap/core/utils/credentials.dart';
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
  final GetStorage box = GetStorage();

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate a splash screen delay

    final bool isFirstTime = box.read('isFirstTime') ?? true;
    if (isFirstTime) {
      box.write('isFirstTime', false);
      Get.offAll(() => const OnboardingScreen());
    } else {
      final String? userId = await appwriteController.getCurrentUserId();
      if (userId != null) {
        final userData = await appwriteController.databases.getDocument(
          databaseId: Credentials.databaseId,
          collectionId: Credentials.usersCollectonId,
          documentId: userId,
        );
        final bool isComplete = userData.data['basicProgress'] ?? false;
        if (isComplete) {
          Get.offAll(() => const HomeContainer());
        } else {
          Get.offAll(() => const CreatePinScreen());
        }
      } else {
        Get.offAll(() => const SignUpScreen());
      }
    }
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
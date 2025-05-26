import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:local_auth/local_auth.dart';
import 'package:uniswap/controllers/database_controller.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/core/utils/credentials.dart';
import 'package:uniswap/core/utils/helpers/loaders.dart';
import 'package:uniswap/core/utils/helpers/network_manager.dart';
import 'package:uniswap/data/saved_data.dart';
import 'package:uniswap/features/authentication/screens/bvn_screen/bvn_popup.dart';
import 'package:uniswap/features/authentication/screens/chose_avatar_colour_screen/chose_avatar_colour_screen.dart';
import 'package:uniswap/features/authentication/screens/chose_avatar_screen/chose_avatar_screen.dart';
import 'package:uniswap/features/authentication/screens/create_pin/create_pin_screen.dart';
import 'package:uniswap/features/authentication/screens/input_uni_screen/input_uni_screen.dart';
import 'package:uniswap/features/authentication/screens/profile_strenght_boost_screen/profile_strenght_boost_screen.dart';
import 'package:uniswap/features/authentication/screens/signin/sign_in_screen.dart';
import 'package:uniswap/features/home/screens/home_container/home_container.dart';
import 'package:uniswap/models/user.dart';

class AuthController extends GetxController {
  AuthController get instance => Get.find();
  final Account account = Account(Get.find<Client>()); // Use Get.find<Client>()
  final Databases databases = Databases(Get.find<Client>()); // Use Get.find<Client>()
  final DatabaseController dataController = Get.put(DatabaseController());

  /// Variables
  final hidePassword = true.obs; // Observable for hiding/showing password
  final profileLoading = false.obs;
  final TextEditingController email = TextEditingController(); // controller for email input
  final TextEditingController name = TextEditingController(); // controller for first name input
  final TextEditingController password = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController linkController = TextEditingController();

  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>(); // Form Key for form validation
  GlobalKey<FormState> signinFormKey = GlobalKey<FormState>(); // Form Key for form validation
  GlobalKey<FormState> profileFormKey = GlobalKey<FormState>(); // Form Key for form validation
  // final BVN variables
  TextEditingController bvn = TextEditingController();
  GlobalKey<FormState> bvnFormKey = GlobalKey<FormState>();
  TextEditingController nin = TextEditingController();
  GlobalKey<FormState> ninFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> changePasswordFormKey = GlobalKey<FormState>();

  /// Touch ID Variable
  final LocalAuthentication _auth = LocalAuthentication();
  RxBool isAuthenticated = false.obs;

  RxInt pinCode = 0.obs; // Use RxInt for numeric pin codes

  // choose Avater
  var selectedImage = ''.obs;

  XFile? pickedImage;

  // Variable to hold the selected date
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  // Observable variable for the selected value
  Rx<String?> selectedGenderValue = Rx<String?>(null);

  @override
  void dispose() {
    email;
    name;
    password;
    pinController;
    bioController;
    linkController;
    super.dispose();
  }

  ///Sign up
  Future<void> signup() async {
    try {
      // Start loading
      // TFullScreenLoader.openLoadingDialog('We are processing your information...', TImages.docerAnimation);
      EasyLoading.show(status: 'We are processing your information...');
      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        EasyLoading.dismiss();
        TLoaders.errorSnackBar(title: 'Oh Snap!', message: "no internet connection");
        return;
      }

      // Form validation
      if (!signupFormKey.currentState!.validate()) {
        EasyLoading.dismiss();
        return;
      }

      final user = await account.create(
        userId: ID.unique(),
        email: email.text.trim(),
        password: password.text.trim(),
        name: name.text.trim(),
      );

      final newUser = UserModel(
        name: name.text.trim(),
        email: email.text.trim(),
        userId: user.$id,
      );

      await account.createEmailPasswordSession(
        email: email.text.trim(),
        password: password.text.trim(),
      );
      await dataController.saveUserRecord(newUser);

      SavedData.saveUserId(user.$id);

      // Remove loader
      EasyLoading.dismiss();

      // Show success message
      TLoaders.successSnackBar(title: 'Congratulations', message: 'Your account has been created');

      // Navigate to the next screen
      Get.off(() => CreatePinScreen());
    } catch (e) {
      // Remove loader
      EasyLoading.dismiss();
      // Show error message
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      // print('Error during signup: $e');
    }
  }

  // Login User
  Future loginUser() async {
    //   // Delete current session if it exists
    final bool login = await checkSessions();
    if (login) {
      await account.deleteSession(sessionId: 'current');
      await SavedData.clearUserData();
    }
    try {
      EasyLoading.show(status: 'We are processing your information...');
      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        EasyLoading.dismiss();
        return;
      }
      // Form validation
      if (!signinFormKey.currentState!.validate()) {
        EasyLoading.dismiss();
        return;
      }
      final user = await account.createEmailPasswordSession(
        email: email.text.trim(),
        password: password.text.trim(),
      );
      SavedData.saveUserId(user.userId);
      if (user.userId == null) {
        print("no user id found");
        return;
      } else {
        final userData = await databases.getDocument(
          databaseId: Credentials.databaseId,
          collectionId: Credentials.usersCollectonId,
          documentId: user.userId,
        );

        SavedData.saveUserData(userData.data);
        // print(user.userId);
        // print(userData.data);
      }

      EasyLoading.dismiss();
      Get.off(() => HomeContainer());

      return true;
    } on AppwriteException catch (e) {
      EasyLoading.dismiss();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } catch (_) {
      EasyLoading.dismiss();
      throw 'An unexpected error occurred. Please try again.';
    }
  }

  Future logoutUser() async {
    try {
      await account.deleteSession(sessionId: 'current');
      await SavedData.clearUserData();
      Get.offAll(() => const SignInScreen());
    } catch (e) {
      // Handle error, show message or retry
      print('Logout failed: $e');
      // Optionally show a snackbar or dialog to inform the user
    }
  }

// check if user have an active session or not
  Future checkSessions() async {
    try {
      await account.getSession(sessionId: 'current');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Session?> checkSession() async {
    try {
      final user = await account.getSession(sessionId: 'current');
      return user;
    } catch (e) {
      return null;
    }
  }

  Future<bool> isUserLoggedIn() async {
    try {
      await account.get();
      return true; // User is logged in
    } catch (e) {
      return false; // User is not logged in
    }
  }

  /// Touch Settings
  Future<void> authenticateUser() async {
    if (!isAuthenticated.value) {
      final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
      if (canAuthenticateWithBiometrics) {
        try {
          final bool didAuthenticate = await _auth.authenticate(
            localizedReason: 'Create Touch Authentication',
            options: const AuthenticationOptions(
              biometricOnly: true,
            ),
          );
          if (didAuthenticate) {
            isAuthenticated.value = true;
            // check internet connectivity
            final isConnected = await NetworkManager.instance.isConnected();
            if (!isConnected) {
              //remove loader
              EasyLoading.dismiss();
              return;
            }

            // update current user biometric data

            await dataController.updateUserDetails({
              "biometric": true,
            });
            EasyLoading.showSuccess('Success!');
            Get.off(() => ChoseAvatarScreen());
          }
          EasyLoading.showSuccess('Success!');
        } catch (e) {
          // Handle error, maybe show a message to the user
          Get.snackbar(
            "Error",
            e.toString(),
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      }
    } else {
      isAuthenticated.value = false;
    }
  }

  // Method to save the pin code to firebase database
  Future<void> savePinCode() async {
    try {
      // start loading
      EasyLoading.show(status: 'We are processing your information...');
      // check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //remove loader
        EasyLoading.dismiss();
        return;
      }

      final pin = pinController.text.trim();

      // Validate the PIN
      if (pin.length != 4 || int.tryParse(pin) == null) {
        //remove loader
        EasyLoading.dismiss();
        TLoaders.warningSnackBar(
          title: "Warning",
          message: "Please input the security code",
        );
        return;
      }
      // update current user pincode data
      await dataController.updateUserDetails({'pincode': pin});

      //remove loader
      EasyLoading.dismiss();
      // show success snack bar
      TLoaders.successSnackBar(title: 'Congratulations', message: 'Pin Created');
      // move to avater screen
      Get.to(() => ChoseAvatarScreen());
    } catch (e) {
      //remove loader
      EasyLoading.dismiss();
      //show some generic error to the user
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      print('Error: $e');
    }
  }

  // Choose Avater
  void setSelectedImage(String image) {
    selectedImage.value = image;
  }

  void chooseAvaterNextButton() {
    if (selectedImage.value.isNotEmpty) {
      Get.to(() => ChoseAvatarColourScreen(selectedImage: selectedImage.value));
    } else {
      Get.snackbar(
        "Oh! Snap",
        "Select an avatar",
        backgroundColor: Colors.blueAccent[100],
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
      );
    }
    print(selectedImage.value);
  }

  // Save Avater Image to  database
  Future<void> avaterNextButton() async {
    try {
      if (selectedImage.value.isEmpty) {
        TLoaders.errorSnackBar(title: 'Oh Snap!', message: 'Please select an image.');
        return;
      }

      EasyLoading.show(status: 'We are processing your information...');

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        EasyLoading.dismiss();
        TLoaders.errorSnackBar(title: 'No Internet', message: 'Please check your internet connection.');
        return;
      }

      String image = selectedImage.value;

      // Upload the image and get the fileId
      await dataController.updateUserDetails({'avatar': image});
      // update the eserdata
      dataController.getUserData();
      EasyLoading.dismiss();

      // display success message
      TLoaders.successSnackBar(title: 'Congratulations', message: 'Avatar Created');

      // Ensure navigation happens on the main thread
      Get.off(() => InputUniScreen());
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  // Choose University
  final List<String> items = [
    'University of lagos',
    'Uniben',
    'Laspotech',
  ];

  // Make selectedValue observable
  Rx<String?> selectedLocationValue = Rx<String?>(null);

  // Method to update selected value
  void setSelectedLocationValue(String? newValue) {
    selectedLocationValue.value = newValue;
  }

  Future<void> saveSelectedUniversity() async {
    try {
      // Start loading
      // TFullScreenLoader.openLoadingDialog('We are processing your information...', TImages.docerAnimation);
      EasyLoading.show(status: 'We are processing your information...');
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        EasyLoading.dismiss();
        TLoaders.errorSnackBar(title: 'No Internet', message: 'Please check your internet connection.');
        return;
      }
      // Validate selected location
      if (selectedLocationValue.value == null || selectedLocationValue.value!.isEmpty) {
        EasyLoading.dismiss();
        TLoaders.errorSnackBar(title: 'Oh Snap!', message: 'Please select a location.');
        return;
      }

      // Get the selected location
      final location = selectedLocationValue.value;

      // Update user data in the database
      await dataController.updateUserDetails({
        'address': location,
        'basicProgress': true,
      });

      //remove loader
      EasyLoading.dismiss();

      // Show success message
      TLoaders.successSnackBar(title: 'Congratulations', message: 'Location Created');

      // Navigate to the next screen
      Get.to(() => ProfileStrenghtBoostScreen());
    } catch (e) {
      EasyLoading.dismiss();
      // Handle errors
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: 'An error occurred. Please try again.');
      print('Error in saveSelectedUniversity: $e');
    } finally {
      // Ensure the loader is stopped
      EasyLoading.dismiss();
    }
  }

  // BVN Section
  Future<void> bvnUpload(context) async {
    EasyLoading.show(status: 'Saving...');
    try {
      final bvnNo = bvn.text.trim();

      // Retrieve the entire user data map
      final userData = SavedData.getUserData();
      // Access individual fields
      final email = userData['email'];
      final userId = SavedData.getUserId();
      // Save user identity with the returned fileId
      await dataController.saveUserIdentity({
        'bvn': bvnNo.toString(),
        'userID': userId,
        'nin': "", // Add NIN if applicable
        'fileId': "", // Use the returned fileId here
      });

      await showDialog(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadiusStyle.roundedBorder10),
          alignment: Alignment.center,
          contentPadding: EdgeInsets.zero,
          backgroundColor: const Color(0xFFFFFFFF),
          children: [
            BvnPopup(
              email: email,
            ),
          ],
        ),
      );
    } catch (e) {
      EasyLoading.dismiss();
      TLoaders.errorSnackBar(title: "Error", message: e.toString());
      print(e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }
  // NIN Section

  Future<void> ninUpload(context) async {
    EasyLoading.show(status: 'Saving...');
    try {
      final ninNo = nin.text.trim();

      // Upload the image and get the fileId
      final fileId = await dataController.uploadImage(Credentials.userBucketId, pickedImage!);
      if (fileId == null) {
        throw Exception("Failed to upload image");
      }
      // Retrieve the entire user data map
      final userData = SavedData.getUserData();
      // Access individual fields
      final email = userData['email'];
      final userId = SavedData.getUserId();
      // Save user identity with the returned fileId
      await dataController.saveUserIdentity({
        'nin': ninNo.toString(),
        'userID': userId,
        'bvn': "", // Add NIN if applicable
        'fileId': fileId, // Use the returned fileId here
      });

      await showDialog(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadiusStyle.roundedBorder10),
          alignment: Alignment.center,
          contentPadding: EdgeInsets.zero,
          backgroundColor: const Color(0xFFFFFFFF),
          children: [
            BvnPopup(
              email: email,
            ),
          ],
        ),
      );
    } catch (e) {
      EasyLoading.dismiss();
      TLoaders.errorSnackBar(title: "Error", message: e.toString());
      print(e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  // profile section
  void updateSelectedDate(DateTime? newDate) {
    selectedDate.value = newDate;
  }

  String get formattedDate {
    if (selectedDate.value == null) return "Select Date";
    return DateFormat('dd/MM/yyyy').format(selectedDate.value!);
  }

  // Genderselect section

  // List of dropdown items
  final List<String> genderItem = ['Male', 'Female'];

  // Method to update the selected value
  void updateSelectedValue(String? value) {
    selectedGenderValue.value = value;
  }

  Future<void> profileUpdate(XFile? image) async {
    try {
      // Start loading
      EasyLoading.show(status: 'We are processing your information...');
      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        EasyLoading.dismiss();
        return;
      }

      // Form validation
      if (!profileFormKey.currentState!.validate()) {
        EasyLoading.dismiss();
        return;
      }

      if (selectedDate.value == null) {
        EasyLoading.dismiss();
        TLoaders.warningSnackBar(title: "Warning", message: "Please choose a date");
        return;
      }

      if (selectedGenderValue.value == null) {
        EasyLoading.dismiss();
        TLoaders.warningSnackBar(title: "Warning", message: "Gender field is required");
        return;
      }

      String fileId;
      if (image == null) {
        EasyLoading.dismiss();
        fileId = "";
      } else {
        // Upload the image and get the fileId
        final imageFileId = await dataController.uploadImage(Credentials.userBucketId, image);
        if (imageFileId == null) {
          throw Exception("Failed to upload image");
        } else {
          fileId = imageFileId;
        }
      }

      // Update user data in the database
      await dataController.updateUserDetails(
        {
          'phone': phoneController.text.trim(),
          'dob': formattedDate.toString(),
          'gender': selectedGenderValue.toString(),
          'photo': fileId,
          'bio': bioController.text.trim(),
          'link': linkController.text.trim(),
        },
      );

      // update the userdata
      await dataController.getUserData();

      // Remove loader
      EasyLoading.dismiss();

      // Show success message
      TLoaders.successSnackBar(title: 'Congratulations', message: 'Your account has been created');

      // Navigate to the next screen
      Get.off(() => HomeContainer());
      // print(formattedDate);
      // print(selectedGenderValue);
    } catch (e) {
      // Remove loader
      EasyLoading.dismiss();
      // Show error message
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      // print('Error during saving data: $e');
    }
  }

  // Method to change password
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String retypePassword,
  }) async {
    EasyLoading.show(status: "Processing");
    try {
      // Validate inputs
      // Call the changePassword method
      if (!changePasswordFormKey.currentState!.validate()) {
        EasyLoading.dismiss();
        return;
      } else if (newPassword != retypePassword) {
        EasyLoading.dismiss();
        TLoaders.errorSnackBar(title: 'Error', message: "New password and retyped password do not match");
      } else {
        // Update password using Appwrite
        await account.updatePassword(
          password: newPassword,
          oldPassword: currentPassword,
        );
        EasyLoading.dismiss();
        // Show success message

        await account.deleteSession(sessionId: 'current');
        await SavedData.clearUserData();
        TLoaders.successSnackBar(title: 'Success', message: 'Password updated successfully');

        // Navigate to SignInScreen
        Get.offAll(() => const SignInScreen());
      }
    } catch (e) {
      // Show error message
      EasyLoading.dismiss();
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  // end controller
}

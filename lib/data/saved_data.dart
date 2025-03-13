import 'package:get_storage/get_storage.dart';

class SavedData {
  static final GetStorage box = GetStorage();

  // Save user id on device
  static Future<void> saveUserId(String id) async {
    await box.write("userId", id);
  }

  // Get the user Id
  static String getUserId() {
    return box.read("userId") ?? "";
  }

  // Save the entire user data as a map
  static Future<void> saveUserData(Map<String, dynamic> userData) async {
    await box.write("userData", userData);
  }

  // Get the entire user data as a map
  static Map<String, dynamic> getUserData() {
    return box.read("userData") ?? {};
  }

  // Clear the saved user data
  static Future<void> clearUserData() async {
    await box.remove("userData");
    await box.remove("userId");
    // print("User data cleared");
  }
}

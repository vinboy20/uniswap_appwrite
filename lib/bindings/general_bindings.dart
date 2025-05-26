import 'package:get/get.dart';
import 'package:uniswap/controllers/product_controller.dart';
import 'package:uniswap/core/utils/helpers/network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    // Get.put(MonnifyController());
    // Get.put(DatabaseController());
    // Get.put(NotificationController());
   
    // Get.put(UserController());
    // Get.put(NotificationController());
    Get.put(ProductController());
    // Get.put(AuthController());
    // Get.put(WishController());
  }
}

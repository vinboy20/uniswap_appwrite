import 'package:get/get.dart';
import 'package:uniswap/core/utils/helpers/network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    // Get.lazyPut(() => ChatController());
    // Get.put(UserController());
  }
}

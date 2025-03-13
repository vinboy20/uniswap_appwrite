import 'package:get/get.dart';
import 'package:uniswap/features/authentication/screens/bvn_screen/bvn_screen.dart';
import 'package:uniswap/features/authentication/screens/change_location_screen/change_location_screen.dart';
import 'package:uniswap/features/authentication/screens/chose_avatar_screen/chose_avatar_screen.dart';
import 'package:uniswap/features/authentication/screens/input_uni_screen/input_uni_screen.dart';
import 'package:uniswap/features/authentication/screens/profile_form_screen/profile_form_screen.dart';
import 'package:uniswap/features/home/screens/chat/chat_tab_container_screen.dart';
import 'package:uniswap/features/home/screens/home_container/home_container.dart';
import 'package:uniswap/features/home/screens/homepage/home_screen.dart';
import 'package:uniswap/features/home/screens/profile/my_profile_screen.dart';
import 'package:uniswap/features/home/screens/swap/upload_item_page.dart';
import 'package:uniswap/features/home/screens/wallet/virtual_wallet_screen.dart';
import 'package:uniswap/features/splash_screen/splash_screen.dart';
import 'package:uniswap/routes/routes.dart';
class AppRoutes {
  static final pages = [
    GetPage(name: TRoutes.homeContainerScreen, page: () => HomeContainer()),
    GetPage(name: TRoutes.splash, page: () => const SplashScreen()),
    GetPage(name: TRoutes.changeLocation, page: () => const ChangeLocationScreen()),
    GetPage(name: TRoutes.chooseUni, page: () => const InputUniScreen()),
    GetPage(name: TRoutes.avater, page: () => ChoseAvatarScreen()),
    GetPage(name: TRoutes.bvnScreen, page: () => BvnScreen()),
    GetPage(name: TRoutes.profileForm, page: () => const ProfileFormScreen()),
    // GetPage(name: TRoutes.bvnScreen, page: () => const BvnScreen()),
    GetPage(name: TRoutes.wallet, page: () => const VirtualWalletScreen()),
    GetPage(name: TRoutes.chat, page: () => const ChatTabContainerScreen()),
    GetPage(name: TRoutes.profile, page: () => const MyProfileScreen()),
    GetPage(name: TRoutes.home, page: () => const HomeScreen()),
    GetPage(name: TRoutes.swap, page: () => const UploadItemPage()),
    // GetPage(name: TRoutes.verifyEmail, page: () => const VerifyEmailScreen()),
    // GetPage(name: TRoutes.signIn, page: () => const LoginScreen()),
    // GetPage(name: TRoutes.forgetPassword, page: () => const ForgetPassword()),
    // GetPage(name: TRoutes.onBoarding, page: () => const OnboardingScreen()),
  ];
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniswap/common/widgets/bottom_bar/custom_bottom_bar.dart';
import 'package:uniswap/controllers/user_controller.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/features/home/screens/chat/chat_tab_container_screen.dart';
import 'package:uniswap/features/home/screens/homepage/home_screen.dart';
import 'package:uniswap/features/home/screens/profile/my_profile_screen.dart';
import 'package:uniswap/features/home/screens/swap/upload_item_page.dart';
import 'package:uniswap/features/home/screens/wallet/virtual_wallet_screen.dart';
import 'package:uniswap/routes/routes.dart';

class HomeContainer extends StatefulWidget {
  const HomeContainer({super.key});

  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  final UserController userController = Get.put(UserController());
  // @override
  // void initState() {
  //   super.initState();
  //   userController.fetchUserData();
  //   // Any initialization logic can go here
  // }

  GlobalKey<NavigatorState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Navigator(
          key: scaffoldKey,
          initialRoute: TRoutes.home,
          onGenerateRoute: (routeSetting) => PageRouteBuilder(
            pageBuilder: (ctx, ani, ani1) => getCurrentPage(routeSetting.name!),
            transitionDuration: const Duration(seconds: 0),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 9.h),
          child: _buildBottomBar(context),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      child: CustomBottomBar(
        onChanged: (BottomBarEnum type) {
          Navigator.pushNamed(scaffoldKey.currentContext!, getCurrentRoute(type));
        },
      ),
    );
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return TRoutes.home;
      case BottomBarEnum.Wallet:
        return TRoutes.wallet;
      case BottomBarEnum.Swap:
        return TRoutes.swap;
      case BottomBarEnum.Chat:
        return TRoutes.chat;
      case BottomBarEnum.Profile:
        return TRoutes.profile;
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case TRoutes.home:
        return const HomeScreen();
      case TRoutes.wallet:
        return const VirtualWalletScreen();
      case TRoutes.swap:
        return const UploadItemPage();
      case TRoutes.chat:
        return const ChatTabContainerScreen();
      case TRoutes.profile:
        return MyProfileScreen();
      default:
        return const DefaultWidget();
    }
  }
}

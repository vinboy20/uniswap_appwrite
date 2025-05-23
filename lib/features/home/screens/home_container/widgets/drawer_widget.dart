import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniswap/common/widgets/button/side_nav_button.dart';
import 'package:uniswap/controllers/auth_controller.dart';
import 'package:uniswap/controllers/product_controller.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/features/home/screens/home_container/home_container.dart';
import 'package:uniswap/features/home/screens/home_container/widgets/user_header_profile.dart';
import 'package:uniswap/features/personalization/screen/settings_screen/settings_screen.dart';
import 'package:uniswap/features/shop/event/ticket_management_screen/ticket_management_screen.dart';
import 'package:uniswap/features/shop/screen/bid_screen/bid_screen.dart';
import 'package:uniswap/features/shop/screen/my_wish_list_screen/my_wish_list_screen.dart';
import 'package:uniswap/features/shop/screen/ticket_category_screen/ticket_category_screen.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  bool isLoading = true; // Add a loading flag
  final controller = Get.put(AuthController());
  final productcontroller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 251.w,
      height: double.maxFinite,
      padding: EdgeInsets.only(left: 24.w, top: 62.h, right: 14.w),
      decoration: BoxDecoration(
        color: const Color(0xFFE2E8F0),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.w),
        ),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserHeaderProfile(),
          SizedBox(height: 52.h),
          SideNavButton(
            icon: Icon(Icons.home_outlined, size: 20.sp, color: Color(0xFF0F172A)),
            text: "Home",
            onTap: () {
              Get.offAll(() => HomeContainer());
            },
          ),
         
          SizedBox(height: 38.h),
          SideNavButton(
            icon: Icon(Icons.favorite_border, size: 20.sp, color: Color(0xFF0F172A)),
            text: "My Watchlist",
            onTap: () {
              Navigator.pop(context);
              Get.to(() => const MyWishListScreen());
            },
          ),
          SizedBox(height: 38.h),
          SideNavButton(
            icon: Icon(Icons.access_time_rounded, size: 20.sp, color: Color(0xFF0F172A)),
            text: "Purchase history",
            onTap: () {
              // Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.ticketCategoryScreen);
              Navigator.pop(context);
              Get.to(() => const TicketCategoryScreen());
            },
          ),
          SizedBox(height: 38.h),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Future.microtask(() {
                Get.to(() => const BidScreen());
              });
            },
            child: Row(
              children: [
                 Icon(Icons.trending_up, size: 20.sp, color: Color(0xFF0F172A)),
                Padding(
                  padding: EdgeInsets.only(left: 18.w, top: 3.h),
                  child: Text(
                    "Bids list",
                    style: CustomTextStyles.text16w400,
                  ),
                ),
                Container(
                  width: 14.w,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 7.w, bottom: 3.h),
                  decoration: TAppDecoration.outlineBlack.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder50,
                  ),
                  child: Text(productcontroller.userBids.length.toString(), style: CustomTextStyles.text12w400cpink),
                ),
              ],
            ),
          ),
          SizedBox(height: 39.h),
          SideNavButton(
            icon: Icon(Icons.notifications_outlined, size: 20.sp, color: Color(0xFF0F172A)),
            text: "Notifications",
            onTap: () {
              Navigator.pop(context);
              // Get.to(() => const NotificationScreen());
            },
          ),
          SizedBox(height: 38.h),
          SideNavButton(
            icon: Icon(Icons.local_offer_outlined, size: 20.sp, color: Color(0xFF0F172A)),
            text: "Ticket Manager",
            onTap: () {
              // Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.ticketManagementScreen);
              Navigator.pop(context);
              Get.to(() => const TicketManagementScreen());
            },
          ),
          SizedBox(height: 38.h),
          SideNavButton(
            icon: Icon(Icons.settings_outlined, size: 20.sp, color: Color(0xFF0F172A)),
            text: "Settings",
            onTap: () {
              Navigator.pop(context);
              Get.to(() => const SettingsScreen());
            },
          ),
          SizedBox(height: 38.h),
          SideNavButton(
            icon: Icon(Icons.help_outline_outlined, size: 20.sp, color: Color(0xFF0F172A)),
            text: "Help",
            onTap: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(height: 38.h),
          SideNavButton(
            icon: Icon(Icons.logout_rounded, size: 20.sp, color: Color(0xFF0F172A)),
            text: "Log Out",
            onTap: () {
              controller.logoutUser();
            },
          ),
          SizedBox(height: 38.h),
        ],
      ),
    );
  }
}

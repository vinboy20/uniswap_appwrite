import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniswap/common/widgets/appbar/appbar.dart';
import 'package:uniswap/common/widgets/appbar/chat_float_button.dart';
import 'package:uniswap/common/widgets/button/custom_outlined_button.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/features/authentication/screens/change_password_screen/change_password_screen.dart';
import 'package:uniswap/features/authentication/screens/delete_account_screen/delete_account_screen.dart';
import 'package:uniswap/features/authentication/screens/signin/sign_in_screen.dart';
import 'package:uniswap/features/personalization/screen/faq_screen/faq_screen.dart';
import 'package:uniswap/features/personalization/screen/manage_notification_screen/manage_notification_screen.dart';
import 'package:uniswap/features/personalization/screen/report_screen/report_screen.dart';
import 'package:uniswap/features/personalization/screen/settings_screen/widget/nav_container.dart';
import 'package:uniswap/theme/custom_button_style.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: chatFloatButton(context),
        appBar: TAppBar(
          showBackArrow: true,
          title: Text(
            "Settings",
            style: CustomTextStyles.text14wbold,
          ),
        ),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            children: [
              navCcontainer(
                context,
                title: "Manage notification",
                onTap: () {
                  Get.to(() => const ManageNotificationScreen());
                },
              ),
              navCcontainer(
                context,
                title: "Manage Password",
                onTap: () {
                  Get.to(() => ChangePasswordScreen());
                },
              ),
              navCcontainer(
                context,
                title: "Delete account",
                onTap: () {
                  Get.to(() => const DeleteAccountScreen());
                },
              ),
              navCcontainer(
                context,
                title: "Report",
                onTap: () {
                  Get.to(() => const ReportScreen());
                },
              ),
              navCcontainer(
                context,
                title: "FAQ's",
                onTap: () {
                  Get.to(() => const FaqScreen());
                },
              ),
              navCcontainer(
                context,
                title: "Log out",
                onTap: () {
                  Get.offAll(() => const SignInScreen());
                },
              ),
              SizedBox(height: 92.h),
              CustomOutlinedButton(
                height: 39.h,
                width: 105.w,
                text: "Rate our app",
                buttonStyle: CustomButtonStyles.outlineTealTL71,
                buttonTextStyle: CustomTextStyles.text14w400,
              ),
            ],
          ),
        ),
      ),
    );
  }

}

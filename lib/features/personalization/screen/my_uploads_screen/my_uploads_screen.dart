import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniswap/common/widgets/appbar/appbar.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/features/personalization/screen/my_uploads_screen/my_active_uploads_screen.dart';


class MyUploadsScreen extends StatelessWidget {
  const MyUploadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: TAppBar(
          showBackArrow: true,
          title: Text(
            "My Upload",
            style: CustomTextStyles.text14wbold,
          ),
        ),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 20.h,
          ),
          child: Column(
            children: [
              _buildStatus(
                context,
                icon: Icons.check_circle_sharp,
                iconColor: TColors.primary,
                status: "Active (0)",
                style: const TextStyle(color: Color(0xFF42D8B9)),
                onTap: () {
                  Get.to(() => MyActiveUploadsScreen());
                  // Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.myActiveUploadsScreen);
                },
              ),
              SizedBox(height: 12.h),
              _buildStatus(
                context,
                icon: Icons.search_outlined,
                iconColor: const Color(0xFFD97706),
                status: "Inspecting (0)",
                style: const TextStyle(color: Color(0xFFD97706)),
                onTap: () {
                  // Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.uploadItemPage);
                  // Navigator.pushNamed(context, AppRoutes.uploadItemPage);
                },
              ),
              SizedBox(height: 12.h),
              _buildStatus(
                context,
                onTap: () {},
                icon: Icons.cancel_outlined,
                iconColor: const Color(0xFFE11D48),
                status: "Disapproved (1)",
                style: const TextStyle(color: Color(0xFFE11D48)),
              ),
              SizedBox(height: 12.h),
              _buildStatus(
                context,
                icon: Icons.do_disturb_on_outlined,
                iconColor: const Color(0xFF1E293B),
                status: "Deactivated (0)",
                style: const TextStyle(color: Color(0xFF1E293B)),
                onTap: () {},
              ),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }

  /// Common widget
  Widget _buildStatus(
    BuildContext context, {
    final IconData? icon,
    final Color? iconColor,
    required String status,
    required TextStyle style,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 20.h,
        ),
        decoration: TAppDecoration.fillGray.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18.sp,
              color: iconColor,
            ),
            SizedBox(width: 6.h),
            Text(
              status,
              style: style,
            ),
            const Spacer(),
            Icon(
              Icons.chevron_right,
              size: 18.sp,
              color: appTheme.blueGray700,
            ),
          ],
        ),
      ),
    );
  }
}

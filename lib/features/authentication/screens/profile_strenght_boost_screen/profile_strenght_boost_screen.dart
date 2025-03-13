import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:uniswap/common/widgets/button/custom_pill_button.dart';
import 'package:uniswap/controllers/auth_controller.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/features/authentication/screens/bvn_screen/bvn_screen.dart';
import 'package:uniswap/features/authentication/screens/profile_form_screen/profile_form_screen.dart';
import 'package:uniswap/features/authentication/screens/profile_strenght_boost_screen/widgets/progress_info.dart';
import 'package:uniswap/features/authentication/screens/profile_strenght_boost_screen/widgets/progress_subtitle.dart';
import 'package:uniswap/features/authentication/screens/profile_strenght_boost_screen/widgets/userprofile_item_widget.dart';

class ProfileStrenghtBoostScreen extends StatelessWidget {
  ProfileStrenghtBoostScreen({super.key});

  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: TSizes.lg, vertical: TSizes.xl),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: TImages.logo,
                  height: 56.h,
                  width: 113.w,
                ),
                SizedBox(height: 13.h),
                Text(
                  "Welcome!",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: TSizes.spaceBtwItems),
                progressSubtitle(context),
                SizedBox(height: TSizes.spaceBtwSections),
                const UserprofileItemWidget(
                  icon: Icons.check_box,
                  value: 1.0,
                  total: 100,
                  text: "Fill up all basic infomation",
                ),
                SizedBox(height: 12.h),
                const UserprofileItemWidget(
                  icon: Icons.check_box_outline_blank_rounded,
                  value: 0.0,
                  total: 0,
                  text: "KYC",
                ),
                SizedBox(height: TSizes.spaceBtwSections),
                progressInfo(context),
                SizedBox(height: 32.h),
                CustomPillButton(
                  color: TColors.primary,
                  onPressed: () {
                    Get.to(() => const BvnScreen());
                  },
                  text: "Continue",
                ),
                SizedBox(height: TSizes.defaultSpace),
                SizedBox(
                  height: 56.h,
                  child: GFButton(
                    onPressed: () {
                      Get.to(() => const ProfileFormScreen());
                    },
                    text: "Skip",
                    fullWidthButton: true,
                    size: GFSize.LARGE,
                    type: GFButtonType.outline,
                    shape: GFButtonShape.pills,
                    borderSide: const BorderSide(color: TColors.borderPrimary),
                    // color: Colors.transparent,
                    textStyle: CustomTextStyles.text14w400cPrimary,
                  ),
                ),
                SizedBox(height: TSizes.spaceBtwSections),
                SizedBox(
                  height: 56.h,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Note',
                          style: TextStyle(
                            color: const Color(0xFFE11D48),
                            fontSize: 14.sp,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const TextSpan(
                          text: ':',
                        ),
                        TextSpan(
                          text: ' As a ',
                          style: CustomTextStyles.text14w400,
                        ),
                        TextSpan(
                          text: 'seller on Uniswap',
                          style: TextStyle(
                            color: const Color(0xFF475569),
                            fontSize: 14.sp,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: ', you are required to meet certain criteria on your profile to become a trusted seller on the application.',
                          style: CustomTextStyles.text14w400,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

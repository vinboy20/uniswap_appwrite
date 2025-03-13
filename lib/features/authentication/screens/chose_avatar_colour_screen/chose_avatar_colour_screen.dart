import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniswap/common/widgets/auth_header.dart';
import 'package:uniswap/common/widgets/button/custom_pill_button.dart';
import 'package:uniswap/controllers/auth_controller.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/core/utils/constraints/text_strings.dart';
import 'package:uniswap/features/authentication/screens/chose_avatar_screen/chose_avatar_screen.dart';

class ChoseAvatarColourScreen extends StatelessWidget {
  ChoseAvatarColourScreen({super.key, required this.selectedImage});

  final String selectedImage;
  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PopScope(
          canPop: false,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: TSizes.lg),
            width: double.maxFinite,
            child: Column(
              children: [
                const AuthHeader(text: TTexts.title),
                SizedBox(height: 16.h),
                Text(
                  TTexts.avaterSubTitle,
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.text14w400,
                ),

                SizedBox(height: TSizes.spaceBtwSections),
                // SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF42D8B9),
                      width: 0.2.w,
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: TColors.primary,
                        width: 0.6.w,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 50.w,
                      backgroundColor: Colors.transparent,
                      child: CustomImageView(
                        imagePath: selectedImage,
                        width: 145.41.w,
                        height: 145.51.h,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                TextButton(
                  child: Text(
                    "Change Avater",
                    style: CustomTextStyles.text14w400cPrimary,
                  ),
                  onPressed: () {
                    Get.to(() => ChoseAvatarScreen());
                  },
                ),
                SizedBox(height: TSizes.spaceBtwSections),
                CustomPillButton(
                  color: TColors.primary,
                  onPressed: () {
                    controller.avaterNextButton();
                  },
                  text: "Next",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

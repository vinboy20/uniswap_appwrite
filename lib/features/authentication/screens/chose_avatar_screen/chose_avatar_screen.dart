import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uniswap/common/widgets/auth_header.dart';
import 'package:uniswap/common/widgets/button/custom_pill_button.dart';
import 'package:uniswap/common/widgets/layouts/grid_layout.dart';
import 'package:uniswap/controllers/auth_controller.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/core/utils/constraints/text_strings.dart';

class ChoseAvatarScreen extends StatelessWidget {
  ChoseAvatarScreen({super.key});

  final List<String> images = [
    'assets/images/avater/avater1.png',
    'assets/images/avater/avater2.png',
    'assets/images/avater/avater3.png',
    'assets/images/avater/avater4.png',
    'assets/images/avater/avater5.png',
    'assets/images/avater/avater6.png',
    'assets/images/avater/avater7.png',
    'assets/images/avater/avater8.png',
    'assets/images/avater/avater9.png',
    'assets/images/avater/avater10.png',
    'assets/images/avater/avater11.png',
    'assets/images/avater/avater12.png',
    // Add more images as needed
  ];

  final storage = GetStorage();
  // String? selectedImage;
  final AuthController signupController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: TSizes.lg),
          margin: const EdgeInsets.only(bottom: TSizes.lg),
          width: THelperFunctions.screenWidth(),
          height: THelperFunctions.screenHeight(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AuthHeader(text: TTexts.title),
              SizedBox(height: 16.h),
              Text(
                TTexts.avaterSubTitle,
                textAlign: TextAlign.center,
                style: CustomTextStyles.text14w400,
              ),
              SizedBox(height: TSizes.defaultSpace),
              Expanded(
                child: TGridLayout(
                  itemCount: images.length,
                  crossAxisCount: 3,
                  mainAxisExtent: 120.h,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () {
                        // setState(() {
                        //   selectedImage = images[index];
                        // });
                        signupController.setSelectedImage(images[index]);
                      },
                      child: Obx(
                        () => Container(
                          margin: const EdgeInsets.all(20), // Keep the width the same for a circular shape
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 3,
                              color: signupController.selectedImage.value == images[index] ? const Color(0xFF42D8B9) : Colors.transparent,
                            ),
                            borderRadius: BorderRadius.circular(50.h), // Half of height/width for perfect rounding
                            image: DecorationImage(
                              image: AssetImage(images[index]),
                              fit: BoxFit.cover, // Ensures the image covers the container
                            ),
                          ),
                          clipBehavior: Clip.antiAlias,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    CustomPillButton(
                      text: "Next",
                      color: TColors.primary,
                      onPressed: () {
                        signupController.chooseAvaterNextButton();
                      },
                    ),
                    SizedBox(height: 14.h),
                    
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

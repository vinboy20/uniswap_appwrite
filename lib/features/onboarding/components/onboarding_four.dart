import 'package:flutter/material.dart';
import 'package:uniswap/core/app_export.dart';

class OnboardingFour extends StatelessWidget {
  const OnboardingFour({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 450.h,
          width: THelperFunctions.screenWidth(),
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomImageView(
                imagePath: TImages.onboardingVector,
              ),
              Positioned(
                right: -15.w,
                child: CustomImageView(
                  height: 390.h,
                  width: 290.h,
                  imagePath: TImages.onboardingFour2,
                ),
              ),
              Positioned(
                left: 0,
                child: CustomImageView(
                  height: 420.h,
                  width: 280.w,
                  imagePath: TImages.onboardingFour1,
                ),
              ),
            ],
          ),
        ),
        //SizedBox(height: 15),
        Column(
          children: [
            Text(
              "Escrow Payment",
              style: CustomTextStyles.text18w600c33,
            ),
            SizedBox(height: 13.h),
            SizedBox(
              child: Text(
                "Enjoy convenient and secure transactions through our Escrow Payment feature",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: CustomTextStyles.text14w400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:uniswap/core/app_export.dart';

class OnboardingThree extends StatelessWidget {
  const OnboardingThree({super.key});

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
              CustomImageView(
                imagePath: TImages.onboardingThree,
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        Column(
          children: [
            Text(
              "Event Ticket Sales ",
              style: CustomTextStyles.text18w600c33,
            ),
            SizedBox(height: 16.h),
            SizedBox(
              width: 304.w,
              child: Text(
                "Easily sell, purchase and manage events tickets ",
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

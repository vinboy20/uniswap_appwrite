import 'package:flutter/material.dart';
import 'package:uniswap/core/app_export.dart';

class OnboardingTwo extends StatelessWidget {
  const OnboardingTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 450.h,
          width: double.maxFinite,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomImageView(
                imagePath: TImages.onboardingVector,
              ),
              CustomImageView(
                margin: EdgeInsets.only(top: 30.h),
                imagePath: TImages.onboardingTwo,
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        Column(
          children: [
            Text(
              "Exclusive Bidding",
              style: CustomTextStyles.text18w600c33,
            ),
            SizedBox(height: 13.h),
            SizedBox(
              width: 331.w,
              child: Text(
                "Experience excitement with a chance to win your desired items at the price you choose",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: CustomTextStyles.text14w400,
              ),
            ),
          ],
        ),
        // SizedBox(height: 25.h),
      ],
    );
  }
}

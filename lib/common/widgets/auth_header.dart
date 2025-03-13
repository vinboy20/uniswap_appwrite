import 'package:flutter/material.dart';
import 'package:uniswap/core/app_export.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key, required this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: TSizes.xl),
      child: Column(
        children: [
          CustomImageView(
            imagePath: TImages.logo,
            height: 56.h,
            width: 113.w,
            alignment: Alignment.center,
          ),
          SizedBox(height: 12.h),
          Text(
            text,
            style: CustomTextStyles.text20bold,
          ),
        ],
      ),
    );
  }
}

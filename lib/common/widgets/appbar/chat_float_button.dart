import 'package:flutter/material.dart';
import 'package:uniswap/core/app_export.dart';

Widget chatFloatButton(BuildContext context) {
  return SizedBox(
    width: 80.w,
    height: 80.h,
    child: Column(
      children: [
        Container(
          height: 50.h,
          width: 50.w,
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            // backgroundBlendMode: BlendMode.color,
            color: TColors.softGrey,
            borderRadius: BorderRadius.circular(50),
          ),
          child: CustomImageView(
            imagePath: TImages.chatIcon,
            color: TColors.primary,
          ),
        ),
        SizedBox(height: 8.h),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            "Chat with us ",
            style: CustomTextStyles.text14w400cPrimary,
          ),
        ),
      ],
    ),
  );
}

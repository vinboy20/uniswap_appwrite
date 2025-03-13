import 'package:flutter/material.dart';
import 'package:uniswap/common/widgets/button/custom_elevated_button.dart';
import 'package:uniswap/common/widgets/layouts/positioning_layout.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/theme/custom_button_style.dart';

/// Section Widget
Widget walletSuccess(
  BuildContext context, {
  required String title,
  // required VoidCallback? onTap,
}) {
  return Center(
    child: Container(
      // width: 342.w,
      height: 302.h,
      decoration: TAppDecoration.fillGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: PositioningLayout(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 80.h,
                width: 80.w,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      height: 80.h,
                      width: 80.w,
                      decoration: TAppDecoration.outlineCyan100.copyWith(
                        borderRadius: BorderRadiusStyle.circleBorder40,
                      ),
                      child: CustomImageView(
                        imagePath: TImages.atmCard,
                        height: 25.h,
                        width: 38.w,
                        alignment: Alignment.center,
                      ),
                    ),
                    Container(
                      height: 17.h,
                      width: 17.w,
                      margin: EdgeInsets.only(right: 4.w),
                      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 4.h),
                      decoration: TAppDecoration.fillCyan.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder6,
                      ),
                      child: Icon(
                        Icons.check_box_sharp,
                        color: TColors.primary,
                        size: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                title,
                style: CustomTextStyles.text14w400cPrimary,
              ),
              SizedBox(height: 38.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: CustomElevatedButton(
                  onPressed: () {
                    // Close the success dialog
                    Navigator.pop(context);
                  },
                  height: 38.h,
                  width: 299.w,
                  text: "Done",
                  buttonStyle: CustomButtonStyles.fillCyanTL7,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniswap/common/widgets/button/custom_elevated_button.dart';
import 'package:uniswap/common/widgets/layouts/positioning_layout.dart';
import 'package:uniswap/controllers/product_controller.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/theme/custom_button_style.dart';

class WithdrawalSucessfulScreen extends StatelessWidget {
  const WithdrawalSucessfulScreen({super.key});

  @override
  Widget build(BuildContext context) {
     final ProductController productController = Get.find<ProductController>();
    return PositioningLayout(
      child: Container(
        height: 342.h,
        decoration: TAppDecoration.fillGray.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 80.h,
            width: 80.w,
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  height: 80.h,
                  width: 80.h,
                  decoration: TAppDecoration.outlineCyan1001.copyWith(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: CustomImageView(
                    imagePath: TImages.paymentConfirm,
                    height: 25.h,
                    width: 38.w,
                    alignment: Alignment.center,
                  ),
                ),
                Container(
                  height: 17.h,
                  width: 17.h,
                  margin: EdgeInsets.only(right: 4.w),
                  padding: EdgeInsets.symmetric(
                    horizontal: 3,
                    vertical: 4,
                  ),
                  decoration: TAppDecoration.fillCyan.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder6,
                  ),
                  child: CustomImageView(
                    imagePath: TImages.checkbox,
                    height: 8.h,
                    width: 9.w,
                    alignment: Alignment.center,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            "Top-up Successful",
            style: CustomTextStyles.text14wboldcPrimary,
          ),
          SizedBox(height: 24.h),
          CustomElevatedButton(
            onPressed: () async {
              // Refresh wallet data
              Get.back();
            },
            height: 38.h,
            width: 299.w,
            text: "Done",
            buttonStyle: CustomButtonStyles.fillCyanTL7,
            alignment: Alignment.center,
          ),
        ],
      ),
      ),
    );
  }
}

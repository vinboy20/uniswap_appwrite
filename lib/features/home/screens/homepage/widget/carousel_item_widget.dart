import 'package:flutter/material.dart';
import 'package:uniswap/core/app_export.dart';

class CarouselItemWidget extends StatelessWidget {
  const CarouselItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: 117.h,
        width: 342.w,
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 12.h,
                ),
                decoration: TAppDecoration.linear.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder10,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Get ",
                            style: CustomTextStyles.text14w400,
                          ),
                          TextSpan(
                            text: "50% off",
                            style: CustomTextStyles.text14w400,
                          ),
                          TextSpan(
                            text: " your first 2 purchase  ",
                            style: CustomTextStyles.text14w400,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 2.h),
                    Opacity(
                      opacity: 0.5,
                      child: Container(
                        width: 246.w,
                        margin: EdgeInsets.only(right: 79.w),
                        child: Text(
                          "Lorem ipsum dolor sit amet consectetur. Sed porttitor tristique at leo sem rhoncus massa eu risus. ",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: CustomTextStyles.text14w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CustomImageView(
              imagePath: TImages.chair,
              height: 116.h,
              width: 68.h,
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(right: 8.h),
            ),
          ],
        ),
      ),
    );
  }
}

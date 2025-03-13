import 'package:flutter/material.dart';
import 'package:uniswap/common/widgets/custom_rating_bar.dart';
import 'package:uniswap/core/app_export.dart';

Widget swapperComment(
  BuildContext context, {
  required String name,
  required String image,
  required String time,
  required String comment,
  required double value,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          CustomImageView(
            imagePath: image,
            height: 44.h,
            width: 44.h,
            radius: BorderRadius.circular(
              50.w,
            ),
          ),
          SizedBox(width: 8.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: CustomTextStyles.text14wbold.copyWith(
                  color: appTheme.gray900,
                ),
              ),
              SizedBox(height: 9.h),
              Text(
                time,
                style: CustomTextStyles.text12w400,
              ),
            ],
          ),
        ],
      ),
      SizedBox(height: 9.h),
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          comment,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: CustomTextStyles.text14w400.copyWith(
            height: 1.43,
          ),
        ),
      ),
      SizedBox(height: 7.h),
      CustomRatingBar(
        alignment: Alignment.centerLeft,
        initialRating: value, 
        onRatingUpdate: (p) {  },
        
      ),
      SizedBox(height: 16.h),
      const Divider(),
      SizedBox(height: 16.h),
      
    ],
  );
}

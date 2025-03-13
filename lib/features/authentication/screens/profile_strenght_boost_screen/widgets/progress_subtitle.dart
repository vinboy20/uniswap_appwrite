import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uniswap/core/app_export.dart';

Widget progressSubtitle(BuildContext context) {
  return SizedBox(
    height: 41.h,
    width: double.maxFinite,
    child: Stack(
      alignment: Alignment.bottomRight,
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            "Boost your profile strength to be a more \n trusted seller",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: CustomTextStyles.text14w400,
          ),
        ),
        CustomImageView(
          imagePath: TImages.imgCheck,
          height: 24.h,
          width: 24.w,
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.only(right: 108.w, top: 20.h),
        )
      ],
    ),
  );
}

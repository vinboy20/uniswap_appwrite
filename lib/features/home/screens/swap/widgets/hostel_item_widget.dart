import 'package:flutter/material.dart';
import 'package:uniswap/common/widgets/button/custom_icon_button.dart';
import 'package:uniswap/core/app_export.dart';

// ignore: must_be_immutable
class HostelItemWidget extends StatelessWidget {
  const HostelItemWidget({
    super.key,
    // required this.categories,
  });

  // final Category categories;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 58.h,
      child: Column(
        children: [
          CustomIconButton(
            height: 58.h,
            width: 58.w,
            padding: EdgeInsets.all(14.h),
            decoration: IconButtonStyleHelper.outlineBlueGray,
            child: CustomImageView(
              imagePath: "images",
            ),
          ),
          SizedBox(height: 3.h),
          Text(
            "title",
            style: CustomTextStyles.text14w600cPrimary,
          ),
        ],
      ),
    );
  }
}

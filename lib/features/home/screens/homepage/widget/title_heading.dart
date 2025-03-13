import 'package:flutter/material.dart';
import 'package:uniswap/core/app_export.dart';
Widget titleHeading(
  BuildContext context, {
  required String popular,
  required String viewAll,
  bool? isDisabled,
  required VoidCallback? onTap,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        popular,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      Padding(
        padding: EdgeInsets.only(bottom: 5.h),
        child: GestureDetector(
          onTap: isDisabled ?? false ? null : onTap ?? () {},
          child: Text(
            viewAll,
            style: CustomTextStyles.text14w400cPrimary.copyWith(
              color: TColors.primary,
            ),
          ),
        ),
      ),
    ],
  );
}

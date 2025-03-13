import 'package:flutter/material.dart';
import 'package:uniswap/core/app_export.dart';

/// Section Widget
Widget navCcontainer(
  BuildContext context, {
  required String title,
  Function? onTap,
}) {
  return SizedBox(
    height: 63.h,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 63.h,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: appTheme.blueGray100, width: 0.3.w),
                bottom: BorderSide(
                  color: appTheme.blueGray100,
                  width: 0.3.w,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 19.h),
          child: GestureDetector(
            onTap: () {
              onTap!.call();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 4.h, bottom: 2.h),
                  child: Text(
                    title,
                    style: CustomTextStyles.text14w400.copyWith(
                      color: appTheme.blueGray700,
                    ),
                  ),
                ),
                const Icon(Icons.chevron_right_outlined, color: TColors.gray200,)
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

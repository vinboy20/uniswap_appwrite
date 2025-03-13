 import 'package:flutter/material.dart';
import 'package:uniswap/core/app_export.dart';

/// Common widget
  Widget profileNav(
    BuildContext context, {
    required String title,
    final IconData? icon,
    Function? onTap,
  }) {
    return GestureDetector(
      onTap: () {
        onTap!.call();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 24.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon, size: 18.sp, color: appTheme.blueGray700,),
            SizedBox(width: 8.h),
            Text(
              title,
              style: CustomTextStyles.text14w400.copyWith(
                color: appTheme.blueGray700,
              ),
            ),
            const Spacer(),
            Icon(Icons.chevron_right, size: 18.sp, color: appTheme.blueGray700,)
          ],
        ),
      ),
    );
  }

import 'package:flutter/material.dart';
import 'package:uniswap/core/app_export.dart';

Widget progressBar(
  BuildContext context, {
  required String text,
  required double value,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        text,
        style: theme.textTheme.bodyMedium,
      ),
      Padding(
        padding: EdgeInsets.only(left: 8.w),
        child: Container(
          height: 6.h,
          width: 157.w,
          decoration: BoxDecoration(
            color: appTheme.tealA100.withOpacity(0.49),
          ),
          child: ClipRRect(
            child: LinearProgressIndicator(
              value: value / 5,
              backgroundColor: appTheme.tealA100.withOpacity(0.49),
              valueColor: AlwaysStoppedAnimation<Color>(
                theme.colorScheme.primary,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

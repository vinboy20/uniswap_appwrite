import 'package:flutter/material.dart';
import 'package:uniswap/core/app_export.dart';

class UserprofileItemWidget extends StatelessWidget {
  const UserprofileItemWidget({
    super.key,
    required this.icon, required this.value, required this.total, required this.text,
  });

  // final Profile profiles;
  final IconData? icon;
  final double value;
  final int total;
  final String text;

  @override
  Widget build(BuildContext context) {
    // dynamic total = profiles.value * 100;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                // profiles.ischecked ? Icons.check_box : Icons.check_box_outline_blank_rounded,
                icon,
                color: TColors.primary,
                size: 18.sp,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Text(
                  // profiles.title,
                  text,
                  style: CustomTextStyles.text14w400,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            SizedBox(
              height: 18.h,
              width: 18.w,
              child: CircularProgressIndicator(
                value: value,
                backgroundColor: TColors.gray100,
                color: TColors.primary,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, top: 4.h, bottom: 4.h),
              child: Text(
                '${total.toInt()}%',
                style: CustomTextStyles.text14w400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

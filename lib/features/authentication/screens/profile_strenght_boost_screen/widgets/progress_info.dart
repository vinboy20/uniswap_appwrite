import 'package:flutter/material.dart';
import 'package:uniswap/core/app_export.dart';

Widget progressInfo(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 15, right: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.info,
          color: TColors.primary,
          size: 18.sp,
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 6.w),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: ' KYC',
                    style: CustomTextStyles.text14w400,
                  ),
                  TextSpan(
                    text: ' gives you access to use the Escrow payment mode on Uniswap for a more secure transaction between buyers and sellers on the app',
                    style: CustomTextStyles.text12w400,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

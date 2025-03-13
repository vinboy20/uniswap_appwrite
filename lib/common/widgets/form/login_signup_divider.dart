import 'package:flutter/material.dart';
import 'package:uniswap/core/app_export.dart';
class LoginSignupDivider extends StatelessWidget {
  const LoginSignupDivider({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Expanded(
          child: Divider(),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Text(text, style: CustomTextStyles.text14w400),
        ),
        const Expanded(
          child: Divider(),
        ),
      ],
    );
  }
}

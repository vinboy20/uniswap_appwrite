import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:uniswap/core/app_export.dart';

class CustomPillButton extends StatelessWidget {
  const CustomPillButton(
      {super.key,
      required this.text,
      // required this.shape,
      this.color,
      this.onPressed});

  final String text;
  // final GFButtonShape shape;
  final Color? color;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.h,
      child: GFButton(
        onPressed: onPressed,
        text: text,
        textStyle: TextStyle(fontSize: 16.sp, color: TColors.textPrimary, fontWeight: FontWeight.w600),
        shape: GFButtonShape.pills,
        color: color ?? TColors.primary,
        fullWidthButton: true,
      ),
    );
  }
}

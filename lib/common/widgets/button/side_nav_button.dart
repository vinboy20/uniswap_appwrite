import 'package:flutter/material.dart';
import 'package:uniswap/core/app_export.dart';
class SideNavButton extends StatelessWidget {
  const SideNavButton({super.key, this.onTap, required this.icon, required this.text});

  final VoidCallback? onTap;
  final Widget icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          icon,
          Padding(
            padding: EdgeInsets.only(left: 18.w),
            child: Text(
              text,
              style: CustomTextStyles.text16w400,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:uniswap/core/app_export.dart';

class TickettumbnailItemWidget extends StatelessWidget {
  const TickettumbnailItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomImageView(
      imagePath: ImageConstant.imgTicketTumbnail,
      height: 336.h,
      width: 342.w,
      radius: BorderRadius.circular(
        13.h,
      ),
    );
  }
}

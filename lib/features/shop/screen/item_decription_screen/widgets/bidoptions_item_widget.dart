import 'package:flutter/material.dart';
import 'package:uniswap/core/app_export.dart';

class Bidoptions2ItemWidget extends StatelessWidget {
  const Bidoptions2ItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RawChip(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
      showCheckmark: false,
      labelPadding: EdgeInsets.zero,
      label: Text(
        "Bid 35,000",
        style: CustomTextStyles.text12wBold,
      ),
      selected: false,
      backgroundColor: TColors.gray300,
      selectedColor: TColors.white,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(
          22,
        ),
      ),
      onSelected: (value) {},
    );
  }
}

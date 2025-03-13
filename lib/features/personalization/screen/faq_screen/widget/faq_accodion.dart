import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:uniswap/core/app_export.dart';

class FaqAccodion extends StatelessWidget {
  const FaqAccodion({
    super.key, required this.title, required this.content,
  });

  final String title;
  final String content;


  @override
  Widget build(BuildContext context) {
    return GFAccordion(
      title: title,
      content: content,
      collapsedIcon: Icon(
        Icons.expand_more,
        size: 18.sp,
      ),
      expandedIcon: Icon(
        Icons.expand_less,
        size: 18.sp,
      ),
      titleBorderRadius: BorderRadius.circular(50),
      titlePadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
      textStyle: CustomTextStyles.text14w400,
      expandedTitleBackgroundColor: TColors.gray50,
      collapsedTitleBackgroundColor: TColors.softGrey
    );
  }
}

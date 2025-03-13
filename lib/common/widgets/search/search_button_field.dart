import 'package:flutter/material.dart';
import 'package:uniswap/common/widgets/search/search_product.dart';
import 'package:uniswap/core/app_export.dart';

class SearchButtonField extends StatelessWidget {
  const SearchButtonField({super.key});

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          useSafeArea: true,
          context: context,
          isScrollControlled: true,
          showDragHandle: true,
          builder: (BuildContext context) {
            return const SearchProduct();
          },
        );
      },
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        width: double.maxFinite,
        height: 50.h,
        decoration: BoxDecoration(
          color: TColors.softGrey,
          borderRadius: BorderRadius.circular(50.w),
        ),
        child: Wrap(
          spacing: 10.w,
          children: [
            Icon(
              Icons.search,
              color: Color(0xFF334155),
              size: 20.sp,
            ),
            Text('Search', style: CustomTextStyles.text14w400),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/features/shop/screen/category_screen/widgets/item_widget.dart';

/// Section Widget
Widget categoryProduct(BuildContext context) {
  return Expanded(
    //flex: 2,
    child: GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisExtent: 204.h,
        crossAxisCount: 2,
        mainAxisSpacing: 22.h,
        crossAxisSpacing: 22.h,
      ),
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: 6,
      //padding: EdgeInsets.symmetric(vertical: 10),
      itemBuilder: (context, index) {
        return ItemWidget(
          index: index,
          onTapProductComponent: () {
            // Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.itemDecriptionScreen);
          },
        );
      },
    ),
  );

}

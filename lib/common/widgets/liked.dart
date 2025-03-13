import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniswap/common/widgets/button/custom_icon_button.dart';
import 'package:uniswap/controllers/wishlist_controller.dart';
import 'package:uniswap/core/app_export.dart';

class Liked extends StatefulWidget {
  final String itemId; // Pass the item ID to the widget
  const Liked({super.key, required this.itemId});

  @override
  State<Liked> createState() => _LikedState();
}

class _LikedState extends State<Liked> {
  final wishcontroller = Get.put(WishController());
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h, right: 10.w),
      child: Obx(() {
        final isInWishlist = wishcontroller.isInWishlist(widget.itemId);
        // print('Is in wishlist: $isInWishlist'); // Debugging

        return CustomIconButton(
          onTap: () => wishcontroller.toggleWishlist(widget.itemId),
          height: 25.h,
          width: 25.h,
          decoration: IconButtonStyleHelper.fillTeal,
          alignment: Alignment.topRight,
          child: Icon(
            Icons.favorite_sharp,
            size: 18.sp,
            color: isInWishlist ? const Color(0xFFE11D48) : Colors.grey,
          ),
        );
      }),
    );
  }
}

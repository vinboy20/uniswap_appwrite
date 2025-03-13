import 'package:flutter/material.dart';
import 'package:uniswap/core/app_export.dart';

Widget noWishlist(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomImageView(
            imagePath: TImages.heart,
            color: appTheme.tealA100,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              'No Wishlist added yet.',
              style: CustomTextStyles.text14w400,
            ),
          ),
        ],
      ),
    );
  }

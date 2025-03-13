import 'package:flutter/material.dart';
import 'package:uniswap/core/app_export.dart';

class PositioningLayout extends StatelessWidget {
  const PositioningLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      // height: THelperFunctions.screenHeight(),
      child: Stack(
        children: [
          Positioned(
            top: -40,
            left: -80,
            child: Opacity(
              opacity: 0.5,
              child: CustomImageView(
                imagePath: TImages.topImage,
                height: 183,
                width: 162,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: child,
          ),
          Positioned(
            bottom: -20,
            right: 0,
            child: Opacity(
              opacity: 0.5,
              child: CustomImageView(
                imagePath: TImages.bottomImage,
                height: 114,
                width: 98,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:uniswap/core/app_export.dart';


class BidEmptyScreen extends StatelessWidget {
  const BidEmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 38.h),
          child: Column(
            children: [
              Spacer(
                flex: 44,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Opacity(
                    opacity: 0.1,
                    child: CustomImageView(
                      width: 200.w,
                      height: 200.h,
                      imagePath: TImages.noBid,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 92.h),
                    padding: EdgeInsets.symmetric(
                      horizontal: 55.w,
                      vertical: 90.h,
                    ),
                    child: Text(
                      "No Bids Yet.",
                      style: theme.textTheme.titleMedium,
                    ),
                  )
                ],
              ),
              Spacer(
                flex: 55,
              ),
            ],
          ),
        ),
      ),
    );
  }

 
}

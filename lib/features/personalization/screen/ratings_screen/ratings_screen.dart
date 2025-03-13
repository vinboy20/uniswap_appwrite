import 'package:flutter/material.dart';
import 'package:uniswap/common/widgets/appbar/appbar.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/features/personalization/screen/profile_screen/widget/progress_bar.dart';

class RatingsScreen extends StatelessWidget {
  const RatingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: TAppBar(
          showBackArrow: true,
          title: Text(
            "Ratings",
            style: CustomTextStyles.text14wbold,
          ),
        ),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.all(24.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Ratings and reviews",
                    style: CustomTextStyles.text14wbold,
                  ),
                ),
                SizedBox(height: 20.h),
                // Rating
                // const RatingUser(),
                SizedBox(height: 32.h),
                progressBar(context, text: "Communication", value: 1),
                SizedBox(height: 22.h),
                progressBar(context, text: "Product quality", value: 0.80),
                SizedBox(height: 22.h),
                progressBar(context, text: "Easy Going", value: 0.5),
                SizedBox(height: 32.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Comments and ratings",
                    style: CustomTextStyles.text14w400,
                  ),
                ),
                SizedBox(height: 16.h),
                // swapperComment(
                //   context,
                //   name: "Samuel Isreal",
                //   time: "8:40am",
                //   value: 3,
                //   comment: "This is a good product",
                // ),

                // swapperComment(
                //   context,
                //   name: "John Doe",
                //   time: "12:40am",
                //   value: 5,
                //   comment: "This is a good product This is a good product This is a good product",
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

 
}

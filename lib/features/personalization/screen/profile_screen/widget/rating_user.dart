import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uniswap/common/widgets/custom_rating_bar.dart';
import 'package:uniswap/controllers/database_controller.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/features/personalization/screen/profile_screen/widget/progress_bar.dart';
import 'package:uniswap/features/personalization/screen/profile_screen/widget/swapper_comment.dart';

class RatingUser extends StatefulWidget {
  const RatingUser({super.key, this.sellerId});
  final String? sellerId;
  @override
  State<RatingUser> createState() => _RatingUserState();
}

class _RatingUserState extends State<RatingUser> {
  final DatabaseController controller = Get.put(DatabaseController());

  String formatTime(String timestamp) {
    try {
      return DateFormat('MMM dd, yyyy').format(DateTime.parse(timestamp));
    } catch (e) {
      return "Invalid date";
    }
  }

 

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 16.sp),
          width: double.infinity,
          decoration: TAppDecoration.fillGray50.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder15,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Overall rating",
                style: theme.textTheme.bodyMedium,
              ),
              SizedBox(height: 18.h),
              Obx(() => Text(
                    controller.overallRating.value.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: 32.sp,
                      color: TColors.textPrimary,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              SizedBox(height: 18.h),
              CustomRatingBar(
                initialRating: controller.overallRating.value,
                itemSize: 34.sp,
                color: appTheme.orange800,
                ignoreGestures: true,
                onRatingUpdate: (p0) {},
              ),
              SizedBox(height: 21.h),
              Text(
                "Based on ${controller.ratings.length} reviews",
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        SizedBox(height: 32.h),
        progressBar(
          context,
          text: "Communication",
          value: controller.ratingProgress['communication'] ?? 0,
        ),
        SizedBox(height: 22.h),
        progressBar(
          context,
          text: "Product quality",
          value: controller.ratingProgress['productQuality'] ?? 0,
        ),
        SizedBox(height: 22.h),
        progressBar(
          context,
          text: "Easy Going",
          value: controller.ratingProgress['easyGoing'] ?? 0,
        ),
        SizedBox(height: 32.h),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Comments and ratings",
            style: CustomTextStyles.text14w400,
          ),
        ),
        SizedBox(height: 16.h),
        ...controller.ratings.map((rating) {
          return swapperComment(
            image: rating.data['avatar'],
            context,
            name: rating.data['name'], // Replace with actual rater name if available
            time: formatTime(rating.data['timestamp']),
            comment: rating.data['comment'] ?? "No comment",
            value: (rating.data['communicationRating'] + rating.data['productQualityRating'] + rating.data['easyGoingRating']) / 3,
          );
        }).toList(),
      ],
    );
  }
}

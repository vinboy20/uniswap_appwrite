import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uniswap/common/widgets/appbar/appbar.dart';
import 'package:uniswap/common/widgets/button/custom_elevated_button.dart';
import 'package:uniswap/common/widgets/custom_rating_bar.dart';
import 'package:uniswap/controllers/database_controller.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/data/saved_data.dart';
import 'package:uniswap/features/home/screens/chat/chatting_screen.dart';
import 'package:uniswap/features/personalization/screen/profile_screen/widget/other_listing.dart';
import 'package:uniswap/features/personalization/screen/profile_screen/widget/progress_bar.dart';
import 'package:uniswap/features/personalization/screen/profile_screen/widget/swapper_comment.dart';
import 'package:uniswap/features/personalization/screen/profile_screen/widget/swapper_profile.dart';
import 'package:uniswap/models/user.dart';
import 'package:uniswap/theme/custom_button_style.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, this.userData});

  final UserModel? userData;
  

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
final currentuserId = SavedData.getUserId();
  String? name;
  String? location;
  String? phone;
  String? email;
  String? avatar;
  String? photo;
  String? bio;
  String? link;
  String? userId;
  final DatabaseController controller = Get.put(DatabaseController());
  String formatTime(String timestamp) {
    try {
      return DateFormat('MMM dd, yyyy').format(DateTime.parse(timestamp));
    } catch (e) {
      return "Invalid date";
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.userData != null) {
      controller.fetchRatings2(widget.userData!.userId!);
      controller.fetchRatings(widget.userData!.userId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.userData != null) {
      name = widget.userData!.name;
      location = widget.userData!.address;
      phone = widget.userData!.phone;
      email = widget.userData!.email;
      avatar = widget.userData!.avatar;
      photo = widget.userData!.photo;
      bio = widget.userData!.bio;
      link = widget.userData!.link;
      userId = widget.userData!.userId;
    }

    return SafeArea(
      child: Scaffold(
        appBar: TAppBar(
          showBackArrow: true,
          title: Text(
            "Swapper Details",
            style: CustomTextStyles.text16Bold,
          ),
        ),
        body: SizedBox(
          width: THelperFunctions.screenWidth(),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24.w),
            child: Column(
              children: [
                // profile
                SwapperProfile(avatar: avatar, photo: photo),
                SizedBox(height: 16.h),
                // name
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name ?? "",
                      style: CustomTextStyles.text14wbold,
                    ),
                    SizedBox(width: 5.h),
                    Icon(
                      Icons.check_circle,
                      color: TColors.primary,
                      size: 16.sp,
                    ),
                  ],
                ),
                SizedBox(height: 17.h),
                Text(
                  "Bio",
                  style: CustomTextStyles.text14w400,
                ),
                SizedBox(height: 13.h),
                // biography
                Text(
                  bio ?? "",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.text14w400.copyWith(
                    height: 1.33,
                  ),
                ),
                SizedBox(height: 24.h),
                // link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.insert_link,
                      color: TColors.blue,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.w),
                      child: Text(
                        link ?? '',
                        style: CustomTextStyles.text14w400cBlue,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                // location
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 18.sp,
                      color: TColors.blue,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.w),
                      child: Text(
                        location ?? "",
                        style: CustomTextStyles.text14w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 14.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomElevatedButton(
                      height: 39.h,
                      width: 169.w,
                      text: "Follow ",
                      buttonStyle: CustomButtonStyles.outlineBlack,
                      buttonTextStyle: CustomTextStyles.text14w400,
                      rightIcon: Icon(
                        Icons.add,
                        color: TColors.textPrimary,
                        size: 12.sp,
                      ),
                    ),
                    if (userId != currentuserId )
                    GestureDetector(
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => ChattingScreen(sellerUserId: userId));
                         
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: const Color(0xFFE2E8F0)),
                            child: Image.asset(
                              "assets/images/Icon_chat.png",
                              height: 14,
                              width: 14,
                            ),
                          ),
                        ),
                      ),
                    )
                    
                    else
                    SizedBox(),
                  ],
                ),
                SizedBox(height: 32.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Icon(
                          Icons.local_phone_outlined,
                          size: 14.sp,
                          color: TColors.blue,
                        ),
                        Text(
                          phone ?? "",
                          style: CustomTextStyles.text14w400cBlue,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 38.h,
                      child: VerticalDivider(
                        width: 1.w,
                        thickness: 1.h,
                        indent: 3.w,
                        endIndent: 3.w,
                      ),
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.mail_outline,
                          size: 14.sp,
                          color: TColors.blue,
                        ),
                        Text(
                          email ?? "",
                          style: CustomTextStyles.text14w400cBlue,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 60.h),
                //Other Listing
                OtherListing(userId: userId),

                SizedBox(height: 32.h),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Ratings and reviews",
                    style: CustomTextStyles.text14wbold,
                  ),
                ),
                SizedBox(height: 20.h),
                // Rating
                // RatingUser(sellerId: userId),
                Obx(() {
                  if (controller.ratings.isEmpty) {
                    return Center(
                      child: Text(
                        "No ratings available",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    );
                  }
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
                      ...controller.allRatings.map((rating) {
                        return swapperComment(
                          image: rating.data['avatar'] ?? "",
                          context,
                          name: rating.data['name'], // Replace with actual rater name if available
                          time: formatTime(rating.data['timestamp']),
                          comment: rating.data['comment'] ?? "No comment",
                          value: (rating.data['communicationRating'] + rating.data['productQualityRating'] + rating.data['easyGoingRating']) / 3,
                        );
                      }),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

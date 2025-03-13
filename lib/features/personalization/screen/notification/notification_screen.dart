import 'package:flutter/material.dart';
import 'package:uniswap/common/widgets/button/custom_elevated_button.dart';
import 'package:uniswap/common/widgets/button/custom_outlined_button.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/features/home/screens/home_container/widgets/drawer_widget.dart';
import 'package:uniswap/theme/custom_button_style.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Notifications",
            style: CustomTextStyles.text14wbold,
          ),
           centerTitle: true,
          actions: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 24.w),
                  child: Stack(
                    children: [
                      Container(
                          width: 38.w,
                          height: 38.w,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFF1F5F9),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(width: 1, color: Color(0xFFE2E8F0)),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          child: Icon(
                            Icons.notifications,
                            size: 23.sp,
                            color: const Color(0xFF42D8B9),
                          )),
                      Positioned(
                        left: 20.w,
                        top: 4,
                        child: Container(
                          alignment: Alignment.center,
                          width: 14.w,
                          height: 14.w,
                          decoration: TAppDecoration.boxWhite.copyWith(
                            borderRadius: BorderRadius.circular(50)
                          ),
                          child: Text("2", style: CustomTextStyles.text12w400cpink),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        drawer: Drawer(
          width: 271.w,
          child: DrawerWidget(),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            children: [
              _buildNotify(context),
              SizedBox(height: 24.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 23.h),
                decoration: TAppDecoration.outlineBlack9007.copyWith(
                  borderRadius: BorderRadiusStyle.customBorderTL20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 6,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      runAlignment: WrapAlignment.center,
                      children: [
                        Icon(
                          Icons.visibility_off,
                          size: 14.sp,
                        ),
                        Text(
                          "Swap code :",
                          style: CustomTextStyles.text12wBold,
                        ),
                        Text(
                          "789674",
                          style: CustomTextStyles.text12wBold.copyWith(color: TColors.primary),
                        ),
                      ],
                    ),
                    SizedBox(height: 11.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 2.h),
                          child: Icon(
                            Icons.access_time,
                            size: 14.sp,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(width: 7.h),
                        Expanded(
                          child: Text(
                            "Only give swap code to seller after receiving and confirming purchase, so escrow funds can be released to seller.",
                            style: CustomTextStyles.text12w400,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 34.h),
              CustomElevatedButton(
                height: 24.h,
                width: 85.w,
                text: "Appeal",
                margin: EdgeInsets.only(right: 3.w),
                buttonStyle: CustomButtonStyles.fillTealA,
                buttonTextStyle: CustomTextStyles.text14w400,
                alignment: Alignment.centerRight,
              ),
              SizedBox(height: 14.h),
              Container(
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.w),
                  border: Border.all(
                    color: const Color(0xFF42D8B9),
                  ),
                  //color: appStore.whiteColor,
                ),
                child: Column(
                  children: [
                    Text(
                      "(Purchase time confirmation countdown) ",
                      style: CustomTextStyles.text12w400,
                    ),
                    SizedBox(height: 14.h),
                    Text(
                      "24hrs : 30mins : 17secs",
                      style: CustomTextStyles.text16Bold.copyWith(color: TColors.pink),
                    ),
                    SizedBox(height: 17.h),
                    Container(
                      width: 289.w,
                      margin: EdgeInsets.only(left: 26.w, right: 25.w),
                      child: Text(
                        "Please confirm your purchase once you receive the item",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: CustomTextStyles.text12w400.copyWith(
                          height: 1.33,
                        ),
                      ),
                    ),
                    SizedBox(height: 19.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomOutlinedButton(
                          width: 128.w,
                          height: 39.h,
                          text: "View Status",
                          buttonTextStyle: CustomTextStyles.text14w400.copyWith(color: TColors.primary),
                          // buttonStyle: ,
                        ),
                        CustomElevatedButton(
                          height: 39.h,
                          width: 175.w,
                          text: "Purchase Confirmed",
                          buttonStyle: CustomButtonStyles.fillCyanTL7,
                          buttonTextStyle: CustomTextStyles.text14w400.copyWith(color: TColors.white),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildNotify(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 23.h),
      decoration: TAppDecoration.outlineBlack9007.copyWith(
        borderRadius: BorderRadiusStyle.customBorderTL20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "You sent payment of ",
                  style: CustomTextStyles.text12w400,
                ),
                TextSpan(
                  text: "₦7000",
                  style: CustomTextStyles.text12wBold,
                ),
                TextSpan(
                  text: " for shelf to ",
                  style: CustomTextStyles.text12w400,
                ),
                TextSpan(
                  text: "Escrow ",
                  style: CustomTextStyles.text12wBold,
                ),
                TextSpan(
                  text: "( Purchase being processed )",
                  style: CustomTextStyles.text14w400cPrimary,
                ),
              ],
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 11.h),
          Text(
            "July 30, 09:43 AM",
            style: CustomTextStyles.text14w400.copyWith(color: TColors.gray200),
          ),
        ],
      ),
    );
  }
}

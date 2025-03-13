import 'package:flutter/material.dart';
import 'package:uniswap/common/widgets/appbar/appbar.dart';
import 'package:uniswap/common/widgets/button/custom_elevated_button.dart';
import 'package:uniswap/common/widgets/form/custom_search_view.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/theme/custom_button_style.dart';

// ignore: must_be_immutable
class MyActiveUploadsScreen extends StatelessWidget {
  MyActiveUploadsScreen({super.key});

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: TAppBar(
          showBackArrow: true,
          title: Text(
            "My Uploads",
            style: CustomTextStyles.text14wbold,
          ),
        ),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          margin: EdgeInsets.only(top: 8.h, bottom: 24.h),
          child: Column(
            children: [
              CustomSearchView(
                controller: searchController,
                hintText: "Search item",
                autofocus: false,
                hintStyle: CustomTextStyles.text12w400,
                contentPadding: EdgeInsets.only(top: 12.h, right: 30.w, bottom: 12.h),
                borderDecoration: SearchViewStyleHelper.fillTeal,
                fillColor: TColors.gray50,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 24.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_circle_sharp,
                            color: TColors.primary,
                            size: 18.sp,
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            "Active (2)",
                            style: CustomTextStyles.text14w400,
                          ),
                        ],
                      ),
                      SizedBox(height: 32.h),
                      ...List.generate(
                        2,
                        (index) => _buildCardDetails(context),
                      ),
                      SizedBox(height: 16.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(right: 42.w),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Note:",
                                  style: CustomTextStyles.text14w400,
                                ),
                                const TextSpan(
                                  text: " ",
                                ),
                                TextSpan(
                                  text: "The inspection process may take a few minutes to hours depending on item.",
                                  style: CustomTextStyles.text14w400,
                                ),
                              ],
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildCardDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDeactivate(context),
        SizedBox(height: 14.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          decoration: TAppDecoration.fillGray50.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder25,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomImageView(
                imagePath: TImages.lamp,
                height: 134.h,
                width: 163.w,
                radius: BorderRadius.circular(10.w),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Reading lamp",
                    style: CustomTextStyles.text14w600cPrimary,
                  ),
                  SizedBox(height: 14.h),
                  Text(
                    "₦7,000",
                    style: CustomTextStyles.text14wbold,
                  ),
                  SizedBox(height: 42.h),
                  CustomElevatedButton(
                    height: 30.h,
                    width: 109.w,
                    text: "Actively on sale",
                    buttonStyle: CustomButtonStyles.outlinetransparent,
                    buttonTextStyle: CustomTextStyles.text12w400cPrimary,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.mode_edit_outline_outlined,
              color: TColors.primary,
              size: 18.sp,
            ),
            Text(
              "edit item",
              style: CustomTextStyles.text14w400cPrimary,
            ),
          ],
        ),
        SizedBox(height: 24.h),
        const Divider(),
        SizedBox(height: 24.h),
      ],
    );
  }

  /// Common widget
  Widget _buildDeactivate(BuildContext context) {
    return SizedBox(
      width: 129.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.do_disturb_on_outlined,
            size: 18.sp,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: Text(
              "Deactivate Item",
              style: CustomTextStyles.text14w400,
            ),
          ),
        ],
      ),
    );
  }
}

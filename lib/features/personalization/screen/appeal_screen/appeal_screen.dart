import 'package:flutter/material.dart';
import 'package:uniswap/common/widgets/button/custom_elevated_button.dart';
import 'package:uniswap/common/widgets/button/custom_icon_button.dart';
import 'package:uniswap/common/widgets/form/custom_text_form_field.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/theme/custom_button_style.dart';
class AppealScreen extends StatefulWidget {
  const AppealScreen({super.key});

  @override
  State<AppealScreen> createState() => _AppealScreenState();
}

class _AppealScreenState extends State<AppealScreen> {
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 34.w, vertical: 28.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Upload your proof as a picture or video",
                  style: theme.textTheme.bodyMedium,
                ),
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.only(right: 109.w),
                  child: Row(
                    children: [
                      // Container(
                      //   margin: EdgeInsets.symmetric(vertical: 1.h),
                      //   padding: EdgeInsets.all(3.w),
                      //   decoration: AppDecoration.fillBluegray100.copyWith(
                      //     borderRadius: BorderRadiusStyle.roundedBorder6,
                      //     image: DecorationImage(
                      //       image: AssetImage(ImageConstant.kettle),
                      //       fit: BoxFit.cover,
                      //     ),
                      //   ),
                      //   child: Column(
                      //     mainAxisSize: MainAxisSize.min,
                      //     crossAxisAlignment: CrossAxisAlignment.end,
                      //     children: [
                      //       SizedBox(height: 45.h),
                      //       Container(
                      //         height: 25.adaptSize,
                      //         width: 25.adaptSize,
                      //         padding: EdgeInsets.all(3.w),
                      //         decoration: AppDecoration.outlineGray6003f.copyWith(borderRadius: BorderRadiusStyle.roundedBorder6),
                      //         child: CustomImageView(
                      //           imagePath: ImageConstant.imgArrowRightOnerror7x7,
                      //           height: 7.adaptSize,
                      //           width: 7.adaptSize,
                      //           alignment: Alignment.center,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Stack(
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.kettle,
                            height: 67.adaptSize,
                            width: 79.adaptSize,
                            alignment: Alignment.center,
                          ),
                          Positioned(
                            top: 2,
                            right: 2,
                            child: Opacity(
                              opacity: 0.5,
                              child: Container(
                                padding: EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Icon(
                                  Icons.close,
                                  size: 13,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 17.w),
                        child: CustomIconButton(
                          height: 70.adaptSize,
                          width: 70.adaptSize,
                          padding: EdgeInsets.all(17.w),
                          decoration: IconButtonStyleHelper.fillGray,
                          child: CustomImageView(
                            imagePath: ImageConstant.imgIconOutlineCamera,
                          ),
                        ),
                      ),
                      Spacer(),
                      CustomImageView(
                        imagePath: ImageConstant.imgIconOutlinePlusSm,
                        height: 35.adaptSize,
                        width: 35.adaptSize,
                        margin: EdgeInsets.symmetric(vertical: 17.h),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32.h),
                CustomTextFormField(
                  controller: commentController,
                  hintText: "Add comment (Please be detailed on issue)",
                  hintStyle: CustomTextStyles.text12w400,
                  textInputAction: TextInputAction.done,
                  maxLines: 5,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                  borderDecoration: TextFormFieldStyleHelper.outlineOnErrorTL81,
                  filled: true,
                  fillColor: theme.colorScheme.onPrimaryContainer.withOpacity(1),
                ),
                SizedBox(height: 5.h)
              ],
            ),
          ),
        ),
        bottomNavigationBar: _buildAppeal(context),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      leadingWidth: 54.w,
      // leading: AppbarLeadingImage(
      //   onTap: () {
      //     Navigator.pop(context);
      //   },
      //   imagePath: ImageConstant.imgIconSolidArrowNarrowLeft,
      //   margin: EdgeInsets.only(left: 34.w),
      // ),
      title: Text(
        "Appeal",
      ),
    );
  }

  /// Section Widget
  Widget _buildAppeal(BuildContext context) {
    return CustomElevatedButton(
      text: "Appeal",
      margin: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 20.h),
      onPressed: () {
        onTapAppeal(context);
      },
    );
  }

  /// Navigates to the popupPlaceholderOneScreen when the action is triggered.
  // onTapAppeal(BuildContext context) {
  //   Navigator.pushNamed(context, AppRoutes.popupPlaceholderOneScreen);
  // }

  Widget _buildAppealConfirm(BuildContext context) {
    return Container(
      width: 342.w,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: TAppDecoration.fillGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Opacity(
            opacity: 0.5,
            child: CustomImageView(
              imagePath: ImageConstant.imgDecorations,
              height: 107.h,
              width: 97.w,
            ),
          ),
          SizedBox(height: 11.h),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              height: 299.h,
              width: 324.w,
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  Opacity(
                    opacity: 0.5,
                    child: CustomImageView(
                      imagePath: ImageConstant.bottomBackground,
                      height: 123.h,
                      width: 136.w,
                      alignment: Alignment.bottomRight,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(right: 14.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Appeal Sent",
                            style: CustomTextStyles.text12w400,
                          ),
                          SizedBox(height: 12.h),
                          CustomIconButton(
                            height: 56.adaptSize,
                            width: 56.adaptSize,
                            padding: EdgeInsets.all(12.w),
                            decoration: IconButtonStyleHelper.fillCyanTL17,
                            child: CustomImageView(
                              imagePath: ImageConstant.imgCheckmark,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Container(
                            width: 299.w,
                            margin: EdgeInsets.symmetric(horizontal: 5.w),
                            child: Text(
                              "We will be in contact with you and ensure we resolve your issue",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.text12w400.copyWith(
                                height: 1.33,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          CustomElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            height: 39.h,
                            text: "Done",
                            buttonStyle: CustomButtonStyles.fillPrimaryTL7,
                            buttonTextStyle: theme.textTheme.labelLarge!,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  onTapAppeal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => SimpleDialog(
        alignment: Alignment.center,
        children: [
          _buildAppealConfirm(context),
        ],
      ),
    );
  }
}

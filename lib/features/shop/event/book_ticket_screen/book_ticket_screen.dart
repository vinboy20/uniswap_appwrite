import 'package:uniswap/common/widgets/button/custom_elevated_button.dart';
import 'package:uniswap/common/widgets/button/custom_icon_button.dart';
import 'package:uniswap/common/widgets/button/custom_outlined_button.dart';
import 'package:uniswap/models/event_model.dart';
import 'package:uniswap/theme/custom_button_style.dart';

import 'widgets/tickettumbnail_item_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:uniswap/core/app_export.dart';

// ignore: must_be_immutable
class BookTicketScreen extends StatelessWidget {
  BookTicketScreen({super.key, required this.event});

  final EventModel event;
  int sliderIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 24.h, bottom: 24.h),
            child: Container(
              margin: EdgeInsets.only(bottom: 5.h),
              padding: EdgeInsets.symmetric(horizontal: 23.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 1.w),
                    child: Text(
                      "Tickets Details",
                      style: CustomTextStyles.titleMediumGray900,
                    ),
                  ),
                  SizedBox(height: 21.h),
                  _buildTicketTumbnail(context),
                  SizedBox(height: 8.h),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 6.h,
                      child: AnimatedSmoothIndicator(
                        activeIndex: sliderIndex,
                        count: 3,
                        axisDirection: Axis.horizontal,
                        effect: ScrollingDotsEffect(
                          spacing: 4,
                          activeDotColor: appTheme.teal500,
                          dotColor: appTheme.teal500.withOpacity(0.4),
                          dotHeight: 6.h,
                          dotWidth: 6.w,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 17.h),
                  Padding(
                    padding: EdgeInsets.only(left: 1.w),
                    child: Text(
                      "The Old Black Peoples Movement",
                      style: CustomTextStyles.titleMediumGray90018,
                    ),
                  ),
                  SizedBox(height: 13.h),
                  Padding(
                    padding: EdgeInsets.only(left: 1.w),
                    child: Text(
                      "By TB. tribe",
                      style: CustomTextStyles.text12w400,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  _buildTime(context),
                  SizedBox(height: 31.h),
                  Divider(
                    indent: 1.w,
                  ),
                  SizedBox(height: 16.h),
                  Padding(
                    padding: EdgeInsets.only(left: 1.w),
                    child: Text(
                      "About Event",
                      style: CustomTextStyles.text12w400,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    width: 290.w,
                    margin: EdgeInsets.only(
                      left: 1.w,
                      right: 52.w,
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                "Lorem ipsum dolor sit amet consectetur. Morbi felis maecenas tellus auctor adipiscing dignissim vitae consectetur. Ligula magnis gravida.....",
                            style: CustomTextStyles.text14w400,
                          ),
                          TextSpan(
                            text: "More details",
                            style: CustomTextStyles.text14w400,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: 14.h),
                  _buildTicketType(context),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1.w),
                    child: _buildEventType(
                      context,
                      iconSolidCollection: ImageConstant.imgIconSolidDatabase,
                      eventType: "Ticket price:",
                      fixedPrice: "₦80,000",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1.w),
                    child: _buildEventType(
                      context,
                      iconSolidCollection: ImageConstant.imgIconSolidCollection,
                      eventType: "Event type:",
                      fixedPrice: "Physical",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1.w),
                    child: _buildEventType(
                      context,
                      iconSolidCollection: ImageConstant.imgIconSolidClock,
                      eventType: "Duration:",
                      fixedPrice: "8:00am - 9:30am",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1.w),
                    child: _buildEventType(
                      context,
                      iconSolidCollection: ImageConstant.imgIconSolidLocationMarker,
                      eventType: "Location:",
                      fixedPrice: "Lorem ipsum dolor sit amet \n consectetur.  Morbi felis maecenas \n tellus auctor adipiscing ",
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Padding(
                    padding: EdgeInsets.only(left: 1.w),
                    child: Text(
                      "Phone number",
                      style: CustomTextStyles.text14w400,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Padding(
                    padding: EdgeInsets.only(left: 1.w),
                    child: Row(
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgSettings,
                          height: 12.adaptSize,
                          width: 12.adaptSize,
                          margin: EdgeInsets.symmetric(vertical: 2.h),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5.w),
                          child: Text(
                            "07073342567",
                            style: CustomTextStyles.text14w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Padding(
                    padding: EdgeInsets.only(left: 1.w),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 7.h,
                            bottom: 5.h,
                          ),
                          child: Text(
                            "Quantity",
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                        Opacity(
                          opacity: 0.3,
                          child: CustomImageView(
                            imagePath: ImageConstant.imgArrowLeft,
                            height: 20.adaptSize,
                            width: 20.adaptSize,
                            margin: EdgeInsets.only(
                              left: 27.w,
                              top: 5.h,
                              bottom: 5.h,
                            ),
                          ),
                        ),
                        _buildOne(context),
                        Opacity(
                          opacity: 0.3,
                          child: CustomImageView(
                            imagePath: ImageConstant.imgArrowRightBlueGray700,
                            height: 20.adaptSize,
                            width: 20.adaptSize,
                            margin: EdgeInsets.only(
                              left: 24.w,
                              top: 5.h,
                              bottom: 5.h,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _buildAddToCalendar(context),
                  SizedBox(height: 28.h),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 4.w,
                      right: 54.w,
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 3.h),
                          child: CustomIconButton(
                            height: 34.h,
                            width: 34.h,
                            padding: EdgeInsets.all(6.w),
                            decoration: IconButtonStyleHelper.fillBlueGrayTL17,
                            child: CustomImageView(
                              imagePath: ImageConstant.imgIconSolidHeart,
                            ),
                          ),
                        ),
                        _buildBuyTicket(context),
                      ],
                    ),
                  ),
                  SizedBox(height: 29.h),
                  Padding(
                    padding: EdgeInsets.only(left: 1.w),
                    child: Text(
                      "Other Events like this",
                      style: CustomTextStyles.text14w400,
                    ),
                  ),
                  SizedBox(height: 13.h),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 1.w,
                      right: 94.w,
                    ),
                    child: Row(
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgThumbnail,
                          height: 85.h,
                          width: 123.w,
                          radius: BorderRadius.circular(
                            10.w,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 14.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "The ProductCon",
                                style: CustomTextStyles.text14w400,
                              ),
                              SizedBox(height: 18.h),
                              Text(
                                "By Mx media",
                                style: theme.textTheme.labelLarge,
                              ),
                              SizedBox(height: 17.h),
                              Text(
                                "July 20th, 8:00PM",
                                style: theme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      leadingWidth: 48.w,
      // leading: AppbarLeadingImage(
      //   onTap: (){
      //     Navigator.pop(context);
      //   },
      //   imagePath: ImageConstant.imgIconSolidArrowNarrowLeft,
      //   margin: EdgeInsets.only(
      //     left: 24.w,
      //     top: 16.h,
      //     bottom: 16.h,
      //   ),
      // ),
      actions: [
        // AppbarTrailingImage(
        //   imagePath: ImageConstant.imgIconOutlineShare,
        //   margin: EdgeInsets.symmetric(
        //     horizontal: 24.w,
        //     vertical: 18.h,
        //   ),
        // ),
      ],
    );
  }

  /// Section Widget
  Widget _buildTicketTumbnail(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 1.w),
      child: CarouselSlider.builder(
        options: CarouselOptions(
          height: 336.h,
          initialPage: 0,
          autoPlay: true,
          viewportFraction: 1.0,
          enableInfiniteScroll: false,
          scrollDirection: Axis.horizontal,
          onPageChanged: (
            index,
            reason,
          ) {
            sliderIndex = index;
          },
        ),
        itemCount: 1,
        itemBuilder: (context, index, realIndex) {
          return TickettumbnailItemWidget();
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildTime(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 1.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 1.h),
            child: Text(
              "Sunday, July 20th 8:00PM ",
              style: CustomTextStyles.text14w400,
            ),
          ),
          Text(
            "5 tickets left",
            style: CustomTextStyles.text14w400,
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildVIP(BuildContext context) {
    return CustomOutlinedButton(
      height: 32.h,
      width: 88.w,
      text: "VIP",
      buttonStyle: CustomButtonStyles.none,
      decoration: CustomButtonStyles.gradientOrangeAFToLightBlueFDecoration,
      buttonTextStyle: CustomTextStyles.text14w400,
    );
  }

  /// Section Widget
  Widget _buildTicketType(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 1.w),
      decoration: TAppDecoration.darkGrey,
      child: DottedBorder(
        color: appTheme.blueGray100,
        padding: EdgeInsets.only(
          left: 1.w,
          top: 1.h,
          right: 1.w,
          bottom: 1.h,
        ),
        strokeWidth: 1.w,
        dashPattern: [
          2,
          2,
        ],
        child: Padding(
          padding: EdgeInsets.only(
            top: 14.h,
            bottom: 13.h,
          ),
          child: Row(
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgIconSolidViewBoards,
                height: 13.h,
                width: 16.w,
                margin: EdgeInsets.symmetric(vertical: 9.h),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 4.w,
                  top: 8.h,
                  bottom: 6.h,
                ),
                child: Text(
                  "Ticket type:",
                  style: CustomTextStyles.text14w400,
                ),
              ),
              Spacer(),
              _buildVIP(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildOne(BuildContext context) {
    return CustomOutlinedButton(
      height: 30.h,
      width: 27.w,
      text: "1",
      margin: EdgeInsets.only(left: 24.w),
      buttonStyle: CustomButtonStyles.outlineOnError,
      buttonTextStyle: theme.textTheme.bodyMedium!,
    );
  }

  /// Section Widget
  Widget _buildAddToCalendar(BuildContext context) {
    return CustomOutlinedButton(
      height: 44.h,
      text: "Add to calendar",
      margin: EdgeInsets.only(left: 1.w),
      leftIcon: Container(
        margin: EdgeInsets.only(right: 8.w),
        child: CustomImageView(
          imagePath: ImageConstant.imgIconOutlineCalendar,
          height: 20.adaptSize,
          width: 20.adaptSize,
        ),
      ),
      buttonStyle: CustomButtonStyles.outlineOnError,
      buttonTextStyle: theme.textTheme.bodyMedium!,
    );
  }

  /// Section Widget
  Widget _buildBuyTicket(BuildContext context) {
    return Expanded(
      child: CustomElevatedButton(
        onPressed: () {
          // Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.ticketManagementScreen);
        },
        height: 38.h,
        text: "Buy Ticket",
        margin: EdgeInsets.only(left: 16.w),
        buttonStyle: CustomButtonStyles.outlineBlack,
        buttonTextStyle: CustomTextStyles.text14w400,
      ),
    );
  }

  /// Common widget
  Widget _buildEventType(
    BuildContext context, {
    required String iconSolidCollection,
    required String eventType,
    required String fixedPrice,
  }) {
    return Container(
      decoration: TAppDecoration.darkGrey,
      child: DottedBorder(
        color: appTheme.blueGray100,
        padding: EdgeInsets.only(
          left: 1.w,
          top: 1.h,
          right: 1.w,
          bottom: 1.h,
        ),
        strokeWidth: 1.w,
        dashPattern: [
          2,
          2,
        ],
        child: Padding(
          padding: EdgeInsets.only(
            top: 14.h,
            bottom: 13.h,
          ),
          child: Row(
            children: [
              CustomImageView(
                color: Color(0xFF42D8B9),
                imagePath: iconSolidCollection,
                height: 16.adaptSize,
                width: 16.adaptSize,
                margin: EdgeInsets.symmetric(vertical: 3.h),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 4.w,
                  top: 4.h,
                ),
                child: Text(
                  eventType,
                  style: CustomTextStyles.text14w400.copyWith(
                    color: appTheme.gray900,
                  ),
                ),
              ),
              Spacer(),
              Container(
                //width: 89.w,
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 2.h,
                ),
                // decoration: AppDecoration.outlineBlack9002.copyWith(
                //   borderRadius: BorderRadiusStyle.roundedBorder10,
                // ),

                child: Text(
                  fixedPrice,
                  style: CustomTextStyles.text14w400.copyWith(
                    color: appTheme.blueGray700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

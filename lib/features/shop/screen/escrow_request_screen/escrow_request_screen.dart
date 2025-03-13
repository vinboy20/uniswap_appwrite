import 'package:flutter/material.dart';
import 'package:uniswap/common/widgets/button/custom_elevated_button.dart';
import 'package:uniswap/common/widgets/layouts/positioning_layout.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/theme/custom_button_style.dart';

class EscrowRequestScreen extends StatefulWidget {
  const EscrowRequestScreen({super.key});

  @override
  State<EscrowRequestScreen> createState() => _EscrowRequestScreenState();
}

class _EscrowRequestScreenState extends State<EscrowRequestScreen> {
  dynamic groupValue;

  @override
  Widget build(BuildContext context) {
    return PositioningLayout(
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        margin: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusStyle.roundedBorder10,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 18.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(height: 28.h),
              Align(
                alignment: Alignment.center,
                child: Text(
                  " Escrow Request",
                  style: CustomTextStyles.text14wboldc19,
                ),
              ),
              SizedBox(height: 18.h),
              // Mode of Exchange
              Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      " Mode of Exchange",
                      style: CustomTextStyles.text14wboldc19,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  _buildRadio(context, title: "Direct", value: 0),
                  _buildRadio(context, title: "Delievery Service", value: 1),
                ],
              ),
              SizedBox(height: 18.h),
              // Location of Exchange
              Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Location of Exchange",
                      style: CustomTextStyles.text14wboldc19,
                    ),
                  ),
                  _buildRadio(context, title: "In-campus", value: 2),
                  _buildRadio(context, title: "Off-campus", value: 3),
                ],
              ),
              SizedBox(height: 18.h),
              // Date of Delievery
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDelieveryDate(context),
                  _buildDelieveryTime(context),
                ],
              ),
              SizedBox(height: 18.h),
              //Confirm button
              CustomElevatedButton(
                onPressed: () {},
                height: 38.h,
                //width: 156.w,
                text: "Confirm",
                buttonStyle: CustomButtonStyles.fillCyan,
                buttonTextStyle: CustomTextStyles.text14wboldc19,
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  /// Common widget
  Widget _buildRadio(
    BuildContext context, {
    required String title,
    required int value,
  }) {
    return Row(
      children: [
        Radio(
          activeColor: const Color(0xFF5DE3D0),
          value: value,
          groupValue: groupValue,
          onChanged: (value) {
            setState(() {
              groupValue = value;
            });
          },
        ),
        Text(title),
      ],
    );
  }

  /// Section Widget
  Widget _buildDelieveryDate(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Delievery date",
          style: CustomTextStyles.text16w400,
        ),
        SizedBox(height: 5.h),
        GestureDetector(
          onTap: () {
            showDatePicker(
              context: context,
              firstDate: DateTime(2000),
              lastDate: DateTime(2030),
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 12.h),
            decoration: ShapeDecoration(
              color: appTheme.gray50,
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Color(0xFF94A3B8)),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 16.sp,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 6.w),
                  child: Text(
                    "24/09/1994",
                    style: CustomTextStyles.text14w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildDelieveryTime(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Delievery time",
          style: CustomTextStyles.text16w400,
        ),
        SizedBox(height: 5.h),
        GestureDetector(
          onTap: () {
            showTimePicker(context: context, initialTime: const TimeOfDay(hour: 12, minute: 00));
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 12.h),
            decoration: ShapeDecoration(
              color: appTheme.gray50,
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Color(0xFF94A3B8)),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock_clock,
                  size: 16.sp,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 6.w),
                  child: Text(
                    "24/09/1994",
                    style: CustomTextStyles.text14w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

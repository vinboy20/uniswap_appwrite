import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uniswap/common/widgets/button/custom_elevated_button.dart';
import 'package:uniswap/common/widgets/layouts/positioning_layout.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/core/utils/helpers/loaders.dart';
import 'package:uniswap/features/shop/screen/escrow_screen.dart';
import 'package:uniswap/theme/custom_button_style.dart';

class EscrowRequestScreen extends StatefulWidget {
  const EscrowRequestScreen({super.key, this.price, this.productId, this.sellerId});

  final String? price;
  final String? productId;
  final String? sellerId;

  @override
  State<EscrowRequestScreen> createState() => _EscrowRequestScreenState();
}

class _EscrowRequestScreenState extends State<EscrowRequestScreen> {
  dynamic exchangeValue;
  dynamic locationValue;
  String? delieveryTime;
  String? delieveryDate;

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
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
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
                  _exchangeRadio(context, title: "Direct", value: "direct"),
                  _exchangeRadio(context, title: "Delievery Service", value: "delievery Service"),
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
                  _locationRadio(context, title: "In-campus", value: "in-campus"),
                  _locationRadio(context, title: "Off-campus", value: "off-campus"),
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
                onPressed: () async {
                  print(exchangeValue);
                  print(locationValue);
                  print(widget.sellerId);
                  if (locationValue == null || exchangeValue == null || delieveryTime == null || delieveryDate == null) {
                    TLoaders.warningSnackBar(title: "Warning", message: "Please fill all required fields.");
                    return;
                  } else {
                    Navigator.pop(context);
                    await showDialog(
                      context: context,
                      builder: (BuildContext context) => SimpleDialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadiusStyle.roundedBorder10),
                        alignment: Alignment.center,
                        contentPadding: EdgeInsets.zero,
                        backgroundColor: const Color(0xFFFFFFFF),
                        children: [
                          EscrowScreen(
                            price: widget.price,
                            productId: widget.productId, 
                            exchange:exchangeValue, 
                            location: locationValue, 
                            delieveryTime: delieveryTime, 
                            delieveryDate: delieveryDate,
                            sellerId: widget.sellerId
                          ),
                        ],
                        // EscrowScreen(price: widget.price, delieveryTime: delieveryTime, delieveryDate: delieveryDate),
                      ),
                    );
                  }
                },
                height: 38.h,
                //width: 156.w,
                text: "Confirm",
                buttonStyle: CustomButtonStyles.fillCyan,
                buttonTextStyle: CustomTextStyles.text14wboldc19,
              ),
              SizedBox(height: 34.h),
            ],
          ),
        ),
      ),
    );
  }

  /// Common widget
  Widget _exchangeRadio(
    BuildContext context, {
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Radio(
          activeColor: const Color(0xFF5DE3D0),
          value: value,
          groupValue: exchangeValue,
          onChanged: (value) {
            setState(() {
              exchangeValue = value;
            });
          },
        ),
        Text(
          title,
          style: TextStyle(color: Color(0xFF0F172A), fontSize: 14.sp, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Widget _locationRadio(
    BuildContext context, {
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Radio(
          activeColor: const Color(0xFF5DE3D0),
          value: value,
          groupValue: locationValue,
          onChanged: (value) {
            setState(() {
              locationValue = value;
            });
          },
        ),
        Text(
          title,
          style: TextStyle(color: Color(0xFF0F172A), fontSize: 14.sp, fontWeight: FontWeight.w400),
        ),
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
          style: CustomTextStyles.text14w400,
        ),
        SizedBox(height: 5.h),
        GestureDetector(
          onTap: () async {
            final DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2101),
            );
            if (pickedDate != null) {
              setState(() {
                delieveryDate = DateFormat('dd/MM/yyyy').format(pickedDate);
              });
            }
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
                    delieveryDate ?? "Select date",
                    style: CustomTextStyles.text12w400,
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
          style: CustomTextStyles.text14w400,
        ),
        SizedBox(height: 5.h),
        GestureDetector(
          onTap: () async {
            final TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (pickedTime != null) {
              setState(() {
                delieveryTime = pickedTime.format(context);
              });
            }
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
                    delieveryTime ?? "select time",
                    style: CustomTextStyles.text12w400,
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

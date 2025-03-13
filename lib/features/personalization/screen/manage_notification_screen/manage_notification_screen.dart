import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:uniswap/common/widgets/appbar/appbar.dart';
import 'package:uniswap/core/app_export.dart';


class ManageNotificationScreen extends StatefulWidget {
  const ManageNotificationScreen({super.key});

  @override
  State<ManageNotificationScreen> createState() => _ManageNotificationScreenState();
}

class _ManageNotificationScreenState extends State<ManageNotificationScreen> {
  bool isSelectedSwitch = false;

  bool isSelectedSwitch1 = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: TAppBar(
          showBackArrow: true,
          title: Text(
            "Manage Notification",
            style: CustomTextStyles.text14wbold,
          ),
        ),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 20.h,
          ),
          child: Column(
            children: [
              Opacity(
                opacity: 0.3,
                child: Divider(
                  color: appTheme.blueGray100.withOpacity(0.46),
                ),
              ),
              SizedBox(height: 21.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: Text(
                        "Push notification",
                        style: CustomTextStyles.text14w400,
                      ),
                    ),
                    // CustomSwitch(
                    //   value: isSelectedSwitch,
                    //   onChange: (value) {
                    //     isSelectedSwitch = value;
                    //   },
                    // ),
                    GFToggle(
                      onChanged: (val) {},
                      value: false,
                      type: GFToggleType.ios,
                    )
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              Opacity(
                opacity: 0.3,
                child: Divider(
                  color: appTheme.blueGray100.withOpacity(0.46),
                ),
              ),
              SizedBox(height: 21.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: Text(
                        "Email notification",
                        style: CustomTextStyles.text14w400,
                      ),
                    ),
                    // CustomSwitch(
                    //   value: isSelectedSwitch1,
                    //   onChange: (value) {
                    //     isSelectedSwitch1 = value;
                    //   },
                    // ),
                    GFToggle(
                      onChanged: (val) {},
                      value: false,
                      type: GFToggleType.ios,
                    )
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              Opacity(
                opacity: 0.3,
                child: Divider(
                  color: appTheme.blueGray100.withOpacity(0.46),
                ),
              ),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }

}

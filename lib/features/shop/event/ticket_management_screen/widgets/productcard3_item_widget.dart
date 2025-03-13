import 'package:flutter/material.dart';
import 'package:uniswap/core/app_export.dart';


class Productcard3ItemWidget extends StatelessWidget {
   const Productcard3ItemWidget({super.key, required this.index,});

  final int index;
  
 
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.ticketManagementScreenSellerOneTabContainerScreen);
      },
      child: Container(
        padding: EdgeInsets.all(16.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(19),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: appTheme.gray50,
              spreadRadius: 2,
              blurRadius: 5,
              //offset: Offset(1, 2), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 3.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomImageView(
                    imagePath: index == 0 ? TImages.ticket : TImages.onboardingThreeOther,
                    height: 95.h,
                    width: 123.h,
                    radius: BorderRadius.circular(
                      10.h,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 13.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "The ProductCon",
                          style: CustomTextStyles.text14w600c0F,
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "By Mx media",
                          style: CustomTextStyles.text14w600c0F,
                        ),
                        SizedBox(height: 18.h),
                        Text(
                          "July 20th, 8:00PM",
                          style: CustomTextStyles.text12w700,
                        ),
                        Text(
                          index == 1 ? "(Done)" : "(Upcoming)",
                          style: index == 1 ? theme.textTheme.bodySmall : CustomTextStyles.text12w400cPrimary,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  CustomImageView(
                    imagePath: ImageConstant.imgNotificationBlueGray10001,
                    height: 26.h,
                    width: 6.w,
                    margin: EdgeInsets.only(bottom: 59.h),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  index == 1 ? "500 SOLD OUT" : "300/500 sold",
                  style: CustomTextStyles.text12w400,
                ),
                Text(
                  "Gross sale",
                  style: CustomTextStyles.text12w400,
                ),
              ],
            ),
            SizedBox(height: 5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 4.h, bottom: 5.h),
                  child: Container(
                    height: 5.h,
                    width: 125.w,
                    decoration: BoxDecoration(
                      color: appTheme.gray50,
                      borderRadius: BorderRadius.circular(
                        2.h,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        2.h,
                      ),
                      child: LinearProgressIndicator(
                        value: 0.58,
                        backgroundColor: index == 1 ? appTheme.blueGray300 : appTheme.teal30001.withOpacity(0.42),
                       
                        valueColor: AlwaysStoppedAnimation<Color>(
                          index == 1 ? appTheme.blueGray300 : appTheme.teal30001,
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  "₦400,000.00",
                  style: index == 1 ? CustomTextStyles.text12w400 : CustomTextStyles.text14w400cPrimary,
                ),
              ],
            ),
            SizedBox(height: 3.h),
          ],
        ),
      ),
    
    );
  }
}

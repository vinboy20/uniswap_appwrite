import 'package:flutter/material.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/data/saved_data.dart';

class ProgressBarUpdate extends StatelessWidget {
  const ProgressBarUpdate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userData = SavedData.getUserData();
    // Access individual fields
     bool? isValidated = userData['isValidated'];
    
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        height: 54.h,
        padding: EdgeInsets.symmetric(vertical: 5.h),
        width: 70.w,
        decoration: TAppDecoration.outlineBlack.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder6,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isValidated == true)
            SizedBox(
              height: 28.h,
              width: 28.w,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 25.h,
                      width: 25.w,
                      child: const CircularProgressIndicator(
                        value: 1,
                        backgroundColor: TColors.grey,
                        color: TColors.primary,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "100%",
                      style: TextStyle(fontSize: 8.sp),
                    ),
                  ),
                ],
              ),
            )
            else

            SizedBox(
              height: 28.h,
              width: 28.w,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 25.h,
                      width: 25.w,
                      child: const CircularProgressIndicator(
                        value: 0.5,
                        backgroundColor: TColors.grey,
                        color: TColors.primary,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "50%",
                      style: TextStyle(fontSize: 8.sp),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 1.h),
            Text(
              "Profile strength",
              style: TextStyle(fontSize: 8.sp),
            ),
          ],
        ),
      ),
    );
  }
}

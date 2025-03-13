import 'package:flutter/material.dart';
import 'package:uniswap/common/widgets/image_preview_widget.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/core/utils/credentials.dart';

class SwapperProfile extends StatelessWidget {
  const SwapperProfile({super.key, this.avatar, this.photo});
  final String? avatar;
  final String? photo;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(
              "33",
              style: CustomTextStyles.text14w400cPrimary,
            ),
            SizedBox(height: 11.h),
            Text(
              "Published",
              style: CustomTextStyles.text14w400,
            ),
          ],
        ),
        Container(
          height: 172.h,
          width: 172.h,
          decoration: TAppDecoration.outlineCyan.copyWith(
            borderRadius: BorderRadius.circular(
              100,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 95.h,
                width: 95.h,
                //margin: EdgeInsets.only(left: 15.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    100,
                  ),
                ),
                child: photo.toString().isNotEmpty
                    ? FilePreviewImage(
                        bucketId: Credentials.userBucketId,
                        fileId: photo ?? "",
                        width: 36.w,
                        height: 36.h,
                        isCircular: true,
                        imageborderRadius: BorderRadius.zero,
                      )
                    : CustomImageView(
                        imagePath: avatar.toString(),
                        width: 36.h,
                        height: 36.h,
                        radius: BorderRadius.circular(50),
                      ),
              ),
              Opacity(
                opacity: 0.75,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 138.h,
                    width: 138.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        100,
                      ),
                      border: Border.all(
                        color: appTheme.cyan200.withOpacity(0.62),
                        width: 1.w,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Text(
              "33",
              style: CustomTextStyles.text14w400cPrimary,
            ),
            SizedBox(height: 11.h),
            Text(
              "Followers",
              style: CustomTextStyles.text14w400,
            ),
          ],
        ),
      ],
    );
  }
}

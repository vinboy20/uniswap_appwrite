import 'package:flutter/material.dart';
import 'package:uniswap/core/app_export.dart';

class OnboardingOne extends StatelessWidget {
  const OnboardingOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              Text("Welcome to", style: CustomTextStyles.text20bold),
              SizedBox(height: 7.h),
              CustomImageView(
                imagePath: TImages.logo,
                height: 68.h,
                width: 137.w,
              )
            ],
          ),
        ),
        SizedBox(height: 48.h),
        SizedBox(
          height: 220.h,
          width: 304.w,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Opacity(
                opacity: 0.6,
                child: CustomImageView(
                  imagePath: TImages.imgRating,
                  height: 14.h,
                  width: 14.h,
                  alignment: Alignment.bottomRight,
                  margin: EdgeInsets.only(right: 118.w, bottom: 32.h),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  height: 75.h,
                  width: 83.w,
                  margin: const EdgeInsets.only(top: 24, right: 9),
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      CustomImageView(
                        imagePath: TImages.imgRating13x14,
                        height: 13.h,
                        width: 14.h,
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(top: 21),
                      ),
                      Opacity(
                        opacity: 0.6,
                        child: CustomImageView(
                          imagePath: TImages.imgSwitch,
                          height: 75.h,
                          width: 75.h,
                          alignment: Alignment.centerRight,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 220.h,
                  width: 304.w,
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      CustomImageView(
                        imagePath: TImages.imgRating19x20,
                        height: 19.h,
                        width: 20.w,
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(left: 115, top: 26),
                      ),
                      Opacity(
                        opacity: 0.6,
                        child: CustomImageView(
                          imagePath: TImages.imgCard,
                          height: 38.h,
                          width: 38.h,
                          alignment: Alignment.topRight,
                          margin: const EdgeInsets.only(top: 8, right: 117),
                        ),
                      ),
                      Opacity(
                        opacity: 0.6,
                        child: CustomImageView(
                          imagePath: TImages.imgContainer,
                          height: 133.h,
                          width: 133.h,
                          alignment: Alignment.topLeft,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: SizedBox(
                          height: 111.h,
                          width: 111.h,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Opacity(
                                opacity: 0.6,
                                child: CustomImageView(
                                  imagePath: TImages.imgSwitch111x111,
                                  height: 111,
                                  width: 111,
                                  alignment: Alignment.center,
                                ),
                              ),
                              Opacity(
                                opacity: 0.6,
                                child: CustomImageView(
                                  imagePath: TImages.imgRating15x15,
                                  height: 15,
                                  width: 15,
                                  alignment: Alignment.topRight,
                                  margin: const EdgeInsets.only(right: 26),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Opacity(
                        opacity: 0.6,
                        child: CustomImageView(
                          imagePath: TImages.imgSwitch94x94,
                          height: 94.h,
                          width: 94.h,
                          alignment: Alignment.bottomLeft,
                          margin: const EdgeInsets.only(left: 51),
                        ),
                      ),
                      Opacity(
                        opacity: 0.9,
                        child: CustomImageView(
                          imagePath: TImages.imgRating20x21,
                          height: 20.h,
                          width: 21.w,
                          alignment: Alignment.bottomLeft,
                          margin: const EdgeInsets.only(left: 30, bottom: 66),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 105.h,
                          width: 105.h,
                          margin: const EdgeInsets.only(top: 51),
                          padding: const EdgeInsets.all(7),
                          decoration: TAppDecoration.darkGrey.copyWith(borderRadius: BorderRadius.circular(15)),
                          child: CustomImageView(
                            imagePath: TImages.imgUniswapLogo,
                            height: 89.h,
                            width: 89.h,
                            alignment: Alignment.center,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 34.h),
        Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                "Connecting Students Exchanging Possibilities",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: CustomTextStyles.text18w600c33,
              ),
            ),
            SizedBox(height: 14.h),
            SizedBox(
              child: Text(
                "Quickly and easily find offers around and on your campus at no extra cost",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: CustomTextStyles.text14w400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

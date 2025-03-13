import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniswap/common/widgets/button/custom_pill_button.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/features/authentication/screens/signup/sign_up_screen.dart';
import 'package:uniswap/features/onboarding/components/onboarding_four.dart';
import 'package:uniswap/features/onboarding/components/onboarding_one.dart';
import 'package:uniswap/features/onboarding/components/onboarding_three.dart';
import 'package:uniswap/features/onboarding/components/onboarding_two.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: -20.w,
              child: Opacity(
                opacity: 0.9,
                child: CustomImageView(
                  imagePath: TImages.topImage,
                  height: 162.h,
                  width: 162.h,
                  alignment: Alignment.centerLeft,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40.h),
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Column(
                children: [
                  Expanded(
                    child: PageView(
                      padEnds: true,
                      scrollDirection: Axis.horizontal,
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      children: const [
                        OnboardingOne(),
                        OnboardingTwo(),
                        OnboardingThree(),
                        OnboardingFour(),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(
                      4,
                      (int index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          width: 8.h,
                          height: 8.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentPage == index ? const Color(0xFF42D8B9) : Colors.grey.shade400,
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 40.0.h),
                  _currentPage == 3
                      ? CustomPillButton(
                          text: "Get Started",
                          color: TColors.primary,
                          onPressed: () {
                            Get.to(() => const SignUpScreen());
                          },
                        )
                      : CustomPillButton(
                          text: "Next",
                          color: TColors.primary,
                          onPressed: () {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          },
                        ),
                  SizedBox(height: 10.h),
                  _currentPage != 3
                      ? TextButton(
                          child: Text(
                            "Skip",
                            style: CustomTextStyles.text14w400,
                          ),
                          onPressed: () {
                            _pageController.jumpToPage(4);
                          },
                        )
                      : SizedBox(height: 35.0.h),
                  SizedBox(height: 15.0.h),
                ],
              ),
            ),
            Positioned(
              child: Opacity(
                opacity: 0.5,
                child: CustomImageView(
                  imagePath: TImages.bottomImage,
                  height: 78.h,
                  width: 78.h,
                  alignment: Alignment.bottomRight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

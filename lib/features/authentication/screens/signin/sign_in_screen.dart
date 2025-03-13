import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniswap/common/widgets/social.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/features/authentication/screens/signin/widget/signin_form.dart';
import 'package:uniswap/common/widgets/form/login_signup_divider.dart';
import 'package:uniswap/features/authentication/screens/signup/sign_up_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SizedBox(
          width: THelperFunctions.screenWidth(),
          height: THelperFunctions.screenHeight(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 40.h, top: TSizes.xl),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomImageView(
                        imagePath: TImages.logo,
                        height: 56.h,
                        width: 113.w,
                        alignment: Alignment.centerLeft,
                      ),
                      SizedBox(height: 16.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome to UniSwap",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "Please type in your information to create a new account",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: CustomTextStyles.text14w400,
                          ),
                        ],
                      ),
                      SizedBox(height: TSizes.spaceBtwSections),

                      /// Form
                      const SigninForm(),

                      SizedBox(height: TSizes.spaceBtwSections),

                      ///Divider
                      const LoginSignupDivider(text: "Or Sign in with"),

                      SizedBox(height: TSizes.spaceBtwItems),

                      ///Socials
                      const SocialAuth(),

                      SizedBox(height: 8.h),
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Not a member?", style: CustomTextStyles.text14w400),
                            GestureDetector(
                              onTap: () {
                                Get.off(() => const SignUpScreen());
                              },
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.w),
                                child: Text(
                                  "Register Now",
                                  style: CustomTextStyles.text14w400cPrimary,
                                ),
                              ),
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:uniswap/common/widgets/appbar/appbar.dart';
import 'package:uniswap/common/widgets/button/custom_elevated_button.dart';
import 'package:uniswap/common/widgets/form/custom_text_form_field.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/core/utils/constraints/text_strings.dart';
import 'package:uniswap/features/personalization/screen/faq_screen/widget/faq_accodion.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  List<String> dropdownItemList = [
    "Item One",
    "Item Two",
    "Item Three",
  ];

  TextEditingController typeyourquestionherevalueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: TAppBar(
          showBackArrow: true,
          title: Text(
            "FAQ's",
            style: CustomTextStyles.text14wbold,
          ),
        ),
        body: SizedBox(
          height: THelperFunctions.screenHeight(),
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.all(24.w),
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      width: 254.w,
                      child: Text(
                        "Frequently Asked Questions:",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: CustomTextStyles.text14w400.copyWith(
                          height: 1.20,
                        ),
                      ),
                    ),
                    SizedBox(height: 32.h),
                    const FaqAccodion(
                      title: TTexts.title1,
                      content: TTexts.content1,
                    ),
                    const FaqAccodion(
                      title: TTexts.title2,
                      content: TTexts.content2,
                    ),
                    const FaqAccodion(
                      title: TTexts.title3,
                      content: TTexts.content3,
                    ),
                    const FaqAccodion(
                      title: TTexts.title3,
                      content: TTexts.content3,
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 5.h,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 23.w,
                    vertical: 43.h,
                  ),
                  // decoration: TAppDecoration.,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTextFormField(
                        controller: typeyourquestionherevalueController,
                        hintText: "Type your question here...",
                        hintStyle: theme.textTheme.bodyLarge!,
                        textInputAction: TextInputAction.done,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 18.h,
                        ),
                        borderDecoration: TextFormFieldStyleHelper.outlineOnErrorTL25,
                        filled: true,
                        fillColor: theme.colorScheme.onPrimaryContainer.withOpacity(1),
                      ),
                      SizedBox(height: 28.h),
                      CustomElevatedButton(
                        text: "Submit your question",
                        buttonTextStyle: CustomTextStyles.text14w400,
                      ),
                    ],
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

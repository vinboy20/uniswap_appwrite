import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniswap/common/widgets/appbar/appbar.dart';
import 'package:uniswap/common/widgets/button/custom_elevated_button.dart';
import 'package:uniswap/common/widgets/form/custom_text_form_field.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/core/utils/validators/validation.dart';
import 'package:uniswap/theme/custom_button_style.dart';
import 'package:uniswap/controllers/user_controller.dart'; // Import UserController

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController inputReportController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final UserController _userController = Get.put(UserController()); // Initialize UserController

  Future<void> _submitReport() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _userController.submitReport(
          email: emailController.text.trim(),
          report: inputReportController.text.trim(),
        );
      } catch (e) {
        // Handle errors (already handled in UserController)
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: TAppBar(
          showBackArrow: true,
          title: Text(
            "Settings",
            style: CustomTextStyles.text14wbold,
          ),
        ),
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.all(24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFormField(
                      controller: emailController,
                      autofocus: false,
                      hintText: "Enter your email address",
                      textInputType: TextInputType.emailAddress,
                      borderDecoration: TextFormFieldStyleHelper.outlineOnError,
                      filled: true,
                      fillColor: TColors.softGrey,
                      validator: TValidator.validateEmail,
                    ),
                    SizedBox(height: 26.h),
                    Text(
                      "What is your report?",
                      style: theme.textTheme.bodyMedium,
                    ),
                    SizedBox(height: 12.h),
                    CustomTextFormField(
                      controller: inputReportController,
                      hintText: "Please be as detailed as possible. Tell us what you expected and what happened instead  ",
                      textInputAction: TextInputAction.done,
                      maxLines: 2,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 23.h,
                      ),
                      borderDecoration: TextFormFieldStyleHelper.outlineOnErrorTL25,
                      filled: true,
                      fillColor: TColors.softGrey,
                    ),
                    SizedBox(height: 36.h),
                    CustomElevatedButton(
                      text: "Submit Report",
                      buttonStyle: CustomButtonStyles.fillTeal,
                      onPressed: _submitReport, // Call the submit report function
                    ),
                    SizedBox(height: 5.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
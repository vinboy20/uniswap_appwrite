import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniswap/common/widgets/appbar/appbar.dart';
import 'package:uniswap/common/widgets/button/custom_elevated_button.dart';
import 'package:uniswap/common/widgets/form/custom_text_form_field.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/theme/custom_button_style.dart';
import 'package:uniswap/controllers/auth_controller.dart'; // Import AuthController

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final AuthController authController = Get.put(AuthController());
  // Initialize AuthController
  final TextEditingController currentPasswordController = TextEditingController();

  final TextEditingController newPasswordController = TextEditingController();

  final TextEditingController retypePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: TAppBar(
          showBackArrow: true,
          title: Text(
            "Manage Password",
            style: CustomTextStyles.text14wbold,
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: Form(
          key: authController.changePasswordFormKey,
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.only(left: 24.w, top: 34.h, right: 24.w),
            child: Column(
              children: [
                _buildCurrentPassword(context),
                SizedBox(height: 24.h),
                _buildNewPassword(context),
                SizedBox(height: 24.h),
                _buildRetypePassword(context),
                SizedBox(height: 32.h),
                CustomElevatedButton(
                  text: "Create Password",
                  buttonStyle: CustomButtonStyles.fillTeal,
                  buttonTextStyle: CustomTextStyles.text16Bold,
                  onPressed: () {
                    authController.changePassword(
                      currentPassword: currentPasswordController.text,
                      newPassword: newPasswordController.text,
                      retypePassword: retypePasswordController.text,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildCurrentPassword(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Current password", style: CustomTextStyles.text14w400),
        SizedBox(height: 4.h),
        Obx(
          () => CustomTextFormField(
            controller: currentPasswordController,
            autofocus: false,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.done,
            suffix: IconButton(
              onPressed: () => authController.hidePassword.value = !authController.hidePassword.value,
              icon: Icon(authController.hidePassword.value ? Icons.visibility : Icons.visibility_off),
              color: Colors.grey[500],
            ),
            suffixConstraints: BoxConstraints(maxHeight: 56.h),
            obscureText: authController.hidePassword.value,
            borderDecoration: TextFormFieldStyleHelper.outlineOnError,
            filled: true,
            fillColor: TColors.softGrey,
            validator: (value) {
              if (value!.isEmpty) {
                return "Password field is required";
              } else if (value.length < 8) {
                return "max of 8 character is required";
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildNewPassword(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("New password", style: CustomTextStyles.text14w400),
        SizedBox(height: 4.h),
        Obx(
          () => CustomTextFormField(
            controller: newPasswordController,
            autofocus: false,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.done,
            suffix: IconButton(
              onPressed: () => authController.hidePassword.value = !authController.hidePassword.value,
              icon: Icon(authController.hidePassword.value ? Icons.visibility : Icons.visibility_off),
              color: Colors.grey[500],
            ),
            suffixConstraints: BoxConstraints(maxHeight: 56.h),
            obscureText: authController.hidePassword.value,
            borderDecoration: TextFormFieldStyleHelper.outlineOnError,
            filled: true,
            fillColor: TColors.softGrey,
            validator: (value) {
              if (value!.isEmpty) {
                return "Password field is required";
              } else if (value.length < 8) {
                return "max of 8 character is required";
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildRetypePassword(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Retype new password", style: CustomTextStyles.text14w400),
        SizedBox(height: 4.h),
        Obx(
          () => CustomTextFormField(
            controller: retypePasswordController,
            autofocus: false,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.done,
            suffix: IconButton(
              onPressed: () => authController.hidePassword.value = !authController.hidePassword.value,
              icon: Icon(authController.hidePassword.value ? Icons.visibility : Icons.visibility_off),
              color: Colors.grey[500],
            ),
            suffixConstraints: BoxConstraints(maxHeight: 56.h),
            obscureText: authController.hidePassword.value,
            borderDecoration: TextFormFieldStyleHelper.outlineOnError,
            filled: true,
            fillColor: TColors.softGrey,
            validator: (value) {
              if (value!.isEmpty) {
                return "Password field is required";
              } else if (value.length < 8) {
                return "max of 8 character is required";
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}

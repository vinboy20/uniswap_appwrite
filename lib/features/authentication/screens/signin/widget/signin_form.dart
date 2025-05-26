import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniswap/common/widgets/button/custom_checkbox_button.dart';
import 'package:uniswap/common/widgets/button/custom_pill_button.dart';
import 'package:uniswap/common/widgets/form/custom_text_form_field.dart';
import 'package:uniswap/controllers/auth_controller.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/core/utils/validators/validation.dart';

class SigninForm extends StatefulWidget {
  const SigninForm({super.key});

  @override
  State<SigninForm> createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
 
  bool rememberMe = false;
  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final _controller = Get.put(AuthController());
    return Form(
      key: _controller.signinFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Email Field
          Text("Email address", style: CustomTextStyles.text14w400),
          SizedBox(height: 8.h),
          CustomTextFormField(
            controller: _controller.email,
            autofocus: false,
            textInputType: TextInputType.emailAddress,
            borderDecoration: TextFormFieldStyleHelper.outlineOnError,
            filled: true,
            fillColor: TColors.softGrey,
            validator: TValidator.validateEmail,
          ),
          SizedBox(height: TSizes.defaultSpace),

          // Password Field
          Text("Password", style: CustomTextStyles.text14w400),
          SizedBox(height: 8.h),
          Obx(
            () => CustomTextFormField(
              controller: _controller.password,
              autofocus: false,
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.done,
              suffix: IconButton(
                onPressed: () => _controller.hidePassword.value = !_controller.hidePassword.value,
                icon: Icon(_controller.hidePassword.value ? Icons.visibility : Icons.visibility_off),
                color: Colors.grey[500],
              ),
              suffixConstraints: BoxConstraints(maxHeight: 56.h),
              obscureText: _controller.hidePassword.value,
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
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomCheckboxButton(
                text: "Remember me",
                value: rememberMe,
                padding: EdgeInsets.symmetric(vertical: 1.h),
                onChange: (value) {
                  rememberMe = value;
                },
              ),
              GestureDetector(
                onTap: () {
                  // onTapTxtForgotPassword(context);
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 2.h),
                  child: Text(
                    "Forgot password?",
                    style: CustomTextStyles.text14w400cPrimary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: TSizes.spaceBtwSections),
          // Register Button
          CustomPillButton(
              text: "Log In",
              color: TColors.primary,
              onPressed: () {
                _controller.loginUser();
              }),
        ],
      ),
    );
  }
}

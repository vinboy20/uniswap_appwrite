import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniswap/common/widgets/button/custom_pill_button.dart';
import 'package:uniswap/common/widgets/form/custom_text_form_field.dart';
import 'package:uniswap/controllers/auth_controller.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/core/utils/validators/validation.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
   
    return Form(
      key: controller.signupFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Full name ", style: CustomTextStyles.text14w400),
          SizedBox(height: 8.h),
          CustomTextFormField(
            // controller: name,
            controller: controller.name,
            autofocus: false,
            textInputType: TextInputType.name,
            borderDecoration: TextFormFieldStyleHelper.outlineOnError,
            filled: true,
            fillColor: TColors.softGrey,
            validator: (value) {
              if (value!.isEmpty) {
                return "Name field is required";
              }
              return null;
            },
          ),
          SizedBox(height: TSizes.defaultSpace),
          // Email Field
          Text("Email address", style: CustomTextStyles.text14w400),
          SizedBox(height: 8.h),
          CustomTextFormField(
            controller: controller.email,
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
              controller: controller.password,
              autofocus: false,
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.done,
              suffix: IconButton(
                onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                icon: Icon(controller.hidePassword.value ? Icons.visibility : Icons.visibility_off),
                color: Colors.grey[500],
              ),
              suffixConstraints: BoxConstraints(maxHeight: 56.h),
              obscureText: controller.hidePassword.value,
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
          SizedBox(height: TSizes.spaceBtwSections),
          // Register Button
          CustomPillButton(
            text: "Register Now",
            color: TColors.primary,
            onPressed: () async {
              controller.signup();
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:uniswap/common/widgets/button/custom_elevated_button.dart';
import 'package:uniswap/common/widgets/form/custom_text_form_field.dart';
import 'package:uniswap/common/widgets/layouts/positioning_layout.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/theme/custom_button_style.dart';

class InputPinScreen extends StatefulWidget {
  const InputPinScreen({
    super.key,
    this.pincontroller,
    required this.onConfirm,
    this.description = "Input your 4-digit pin to complete transaction",
    this.buttonText = "Confirm Payment",
    required this.title,
    required this.validator,
  });

  final TextEditingController? pincontroller;
  final VoidCallback onConfirm;
  final String title;
  final String description;
  final String buttonText;
  final FormFieldValidator<String>? validator;

  @override
  State<InputPinScreen> createState() => _InputPinScreenState();
}

class _InputPinScreenState extends State<InputPinScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return PositioningLayout(
      child: Container(
        height: 317.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(left: 16.w, right: 16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.title,
                    // "INPUT PIN",
                    style: CustomTextStyles.text14w400,
                  ),
                ),
                SizedBox(height: 8.h),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.description,
                    // "Input your 4-digit pin to complete transaction",
                    style: CustomTextStyles.text12w400,
                  ),
                ),
                SizedBox(height: 27.h),
                Form(
                  key: formKey,
                  child: CustomTextFormField(
                    controller: widget.pincontroller,
                    hintText: "****",
                    obscureText: true,
                    textInputType: TextInputType.number,
                    hintStyle: CustomTextStyles.text12w400,
                    textInputAction: TextInputAction.done,
                    validator: widget.validator,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 11.w,
                      vertical: 8.h,
                    ),
                  ),
                ),
                SizedBox(height: 27.h),
                CustomElevatedButton(
                 onPressed: () {
                    if (!formKey.currentState!.validate()) return;
                    widget.onConfirm(); // <-- FIXED: Call the function
                  },
                  // onPressed: widget.onConfirm,
                  height: 39.h,
                  text: "Confirm Payment",
                  buttonStyle: CustomButtonStyles.fillPrimaryTL7,
                  buttonTextStyle: theme.textTheme.labelLarge!,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

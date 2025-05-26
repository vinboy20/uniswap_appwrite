import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uniswap/common/widgets/auth_header.dart';
import 'package:uniswap/common/widgets/button/custom_pill_button.dart';
import 'package:uniswap/common/widgets/form/custom_pin_code_text_field.dart';
import 'package:uniswap/controllers/auth_controller.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/features/authentication/screens/biometric/touch_id.dart';

class CreatePinScreen extends StatefulWidget {
  const CreatePinScreen({super.key});

  @override
  State<CreatePinScreen> createState() => _CreatePinScreenState();
}

class _CreatePinScreenState extends State<CreatePinScreen> {
  final AuthController signupController = Get.find<AuthController>();
  final storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: TSizes.lg),
          child: Column(
            children: [
              const AuthHeader(text: "Security Code"),
              SizedBox(height: TSizes.spaceBtwSections),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.w),
                  ),
                ),
                padding: const EdgeInsets.all(TSizes.lg),
                child: Column(
                  children: [
                    Text(
                      "Create a pin code to secure your account",
                      style: CustomTextStyles.text14w400,
                    ),
                    SizedBox(height: TSizes.spaceBtwSections),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
                      child: CustomPinCodeTextField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Pin code is required";
                          }
                          if (value.length != 4 || int.tryParse(value) == null) {
                            return "PIN must be a 4-digit number.";
                          }
                          return null;
                        },
                        context: context,
                        controller: signupController.pinController,
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: TSizes.spaceBtwSections),

              ///Touch ID
              const TouchId(),

              SizedBox(height: TSizes.defaultSpace),

              /// Face ID
              // const FaceId(),

              // SizedBox(height: TSizes.defaultSpace),
              CustomPillButton(
                text: "Next",
                color: TColors.primary,
                onPressed: () async {
                  signupController.savePinCode();
                  // GetStorage().erase();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Navigates to the touchIdScreen when the action is triggered.

  void showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.only(bottom: 0, left: 20, right: 20),
          title: Text(
            "Do you want to allow “UniSwap” to use Face ID",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: CustomTextStyles.text14w400,
          ),
          content: Container(
            margin: const EdgeInsets.only(top: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  child: Text(
                    "Allow Face ID to authenticate on UniSwap",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: CustomTextStyles.text14w400,
                  ),
                ),
                SizedBox(height: 8.h),
                // Divider(color: theme.colorScheme.onError, thickness: 0.5),
                SizedBox(height: 3.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Don’t Allow",
                        style: CustomTextStyles.text16w400,
                      ),
                    ),
                    Container(
                      width: 80.w,
                      margin: const EdgeInsets.only(left: 32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 47.h,
                            child: const VerticalDivider(
                              width: 1,
                              thickness: 1,
                              // color: theme.colorScheme.onError,
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await EasyLoading.showSuccess('Face ID');
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Allow",
                              style: CustomTextStyles.text16w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

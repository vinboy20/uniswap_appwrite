import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:uniswap/common/widgets/appbar/appbar.dart';
import 'package:uniswap/common/widgets/button/custom_pill_button.dart';
import 'package:uniswap/common/widgets/form/custom_text_form_field.dart';
import 'package:uniswap/controllers/auth_controller.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/features/authentication/screens/nin_screen/nin_screen.dart';

class BvnScreen extends StatefulWidget {
  const BvnScreen({super.key});

  @override
  State<BvnScreen> createState() => _BvnScreenState();
}

class _BvnScreenState extends State<BvnScreen> {

  final controller = Get.find<AuthController>();
 
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: TAppBar(
          leadingOnPressed: () {
            Navigator.pop(context);
          },
          showBackArrow: true,
          title: const Text("Personal Details"),
        ),
        body: Container(
          margin: const EdgeInsets.only(bottom: 5),
          padding: const EdgeInsets.symmetric(horizontal: TSizes.lg),
          width: THelperFunctions.screenWidth(),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  height: 54.h,
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  width: 70.w,
                  decoration: TAppDecoration.outlineBlack.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder6,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 28.h,
                        width: 28.w,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                height: 25.h,
                                width: 25.w,
                                child: const CircularProgressIndicator(
                                  value: 0.5,
                                  backgroundColor: TColors.grey,
                                  color: TColors.primary,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "50%",
                                style: TextStyle(fontSize: 8.sp),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        "Profile strength",
                        style: TextStyle(fontSize: 8.sp),
                      ),
                    ],
                  ),
                ),
              ),

             
              SizedBox(height: TSizes.spaceBtwSections),
              Text(
                "BVN ",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 14.h),
              Text(
                "This information is needed for enhancing security, reducing fraud, and complying with regulatory requirements.",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: CustomTextStyles.text14w400,
              ),
              SizedBox(height: TSizes.spaceBtwSections),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Input BVN",
                    style: CustomTextStyles.text16Bold,
                  ),
                  SizedBox(height: 4.h),
                  // Form
                  Form(
                    key: controller.bvnFormKey,
                    child: CustomTextFormField(
                      controller: controller.bvn,
                      hintText: "0",
                      hintStyle: CustomTextStyles.text12w400,
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.number,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 19),
                      borderDecoration: TextFormFieldStyleHelper.outlineGrey200,
                      filled: true,
                      fillColor: TColors.white,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Bvn field is required";
                        } else if (value.length < 11 || value.length > 11) {
                          return "max of 11 character is required";
                        }
                        return null;
                      },
                    ),
                  ),
                
                ],
              ),
              SizedBox(height: 19.h),
              GestureDetector(
                onTap: () {
                  Get.to(() => const NinScreen());
                },
                child: Text(
                  "Use NIN instead",
                  style: CustomTextStyles.text14w400cPrimary,
                ),
              ),
              SizedBox(height: TSizes.spaceBtwSections),
              CustomPillButton(
                color: TColors.primary,
                onPressed: () async {
                  if (!controller.bvnFormKey.currentState!.validate()) {
                    return;
                  }  else {
                    controller.bvnUpload(context);
                    EasyLoading.dismiss();
                  }
                },
                text: "Next",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:uniswap/common/widgets/button/custom_pill_button.dart';
import 'package:uniswap/controllers/auth_controller.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/features/authentication/screens/change_location_screen/change_location_screen.dart';

class InputUniScreen extends StatelessWidget {
  const InputUniScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(TSizes.lg),
          margin: const EdgeInsets.only(bottom: TSizes.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImageView(
                imagePath: TImages.logo,
                height: 56.h,
                width: 113.w,
              ),
              SizedBox(height: 21.h),
              Text(
                "Welcome!",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 16.h),
              SizedBox(
                width: 340.w,
                child: Text(
                  "Input University to help you better connect with other users",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.text14w400,
                ),
              ),
              SizedBox(height: 38.h),
              // DropdownButtonHideUnderline(
              //   child: DropdownButton2<String>(
              //     isExpanded: true,
              //     hint: Text(
              //       'Input university',
              //       style: CustomTextStyles.text12w400,
              //       overflow: TextOverflow.ellipsis,
              //     ),
              //     items: controller.items
              //         .map((String value) => DropdownMenuItem<String>(
              //               value: value,
              //               child: Text(
              //                 value,
              //                 style: CustomTextStyles.text14w400,
              //                 overflow: TextOverflow.ellipsis,
              //               ),
              //             ))
              //         .toList(),
              //     value: controller.selectedValue,
              //     onChanged: (String? newValue) {
              //       controller.setSelectedValue(newValue);
              //       controller.update();
              //     },
              //     buttonStyleData: ButtonStyleData(
              //       height: 50.h,
              //       padding: const EdgeInsets.only(left: 14, right: 14),
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(25.w),
              //         color: const Color(0xFFF1F5F9),
              //       ),
              //     ),
              //     iconStyleData: IconStyleData(
              //       icon: const Icon(
              //         Icons.expand_more,
              //       ),
              //       iconSize: 25.sp,
              //       iconEnabledColor: Colors.grey,
              //       iconDisabledColor: Colors.grey,
              //     ),
              //     dropdownStyleData: DropdownStyleData(
              //       maxHeight: 200.h,
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.w), bottomRight: Radius.circular(10.w)),
              //         color: Colors.white,
              //       ),
              //       //offset: const Offset(0, 0),
              //       scrollbarTheme: ScrollbarThemeData(
              //         radius: Radius.circular(40.w),
              //         thickness: WidgetStateProperty.all(6),
              //         thumbVisibility: WidgetStateProperty.all(true),
              //       ),
              //     ),
              //     menuItemStyleData: MenuItemStyleData(
              //       height: 40.h,
              //       padding: const EdgeInsets.only(left: 14, right: 14),
              //     ),
              //   ),
              // ),

              Obx(() {
                return DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: Text(
                      'Input university',
                      style: CustomTextStyles.text12w400,
                      overflow: TextOverflow.ellipsis,
                    ),
                    items: controller.items
                        .map((String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: CustomTextStyles.text14w400,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    value: controller.selectedLocationValue.value, // Use .value to get the observable value
                    onChanged: (String? newValue) {
                      controller.setSelectedLocationValue(newValue); // Update the observable value
                    },
                    buttonStyleData: ButtonStyleData(
                      height: 50.h,
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.w),
                        color: const Color(0xFFF1F5F9),
                      ),
                    ),
                    iconStyleData: IconStyleData(
                      icon: const Icon(Icons.expand_more),
                      iconSize: 25.sp,
                      iconEnabledColor: Colors.grey,
                      iconDisabledColor: Colors.grey,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10.w),
                          bottomRight: Radius.circular(10.w),
                        ),
                        color: Colors.white,
                      ),
                    ),
                    menuItemStyleData: MenuItemStyleData(
                      height: 40.h,
                      padding: const EdgeInsets.only(left: 14, right: 14),
                    ),
                  ),
                );
              }),

              SizedBox(height: 26.h),
              GFButton(
                onPressed: () {
                  Get.to(() => const ChangeLocationScreen());
                },
                text: "Use Location",
                textStyle: CustomTextStyles.text14w400cPrimary,
                type: GFButtonType.transparent,
              ),
              const Spacer(),
              CustomPillButton(
                color: TColors.primary,
                onPressed: () {
                  controller.saveSelectedUniversity();
                },
                text: "Continue",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:uniswap/common/widgets/appbar/appbar.dart';
import 'package:uniswap/common/widgets/button/custom_elevated_button.dart';
import 'package:uniswap/controllers/user_controller.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/core/utils/helpers/loaders.dart';
import 'package:uniswap/data/saved_data.dart';
import 'package:uniswap/features/authentication/screens/signin/sign_in_screen.dart';
import 'package:uniswap/theme/custom_button_style.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  final _usercontroller = Get.put(UserController());
  final List<String> items = [
    'I dont want to be a member anymore',
    'Noting',
    'Just Delele the fucking account',
  ];
  String? selectedValue;

  // Future<void> _showConfirmationDialog() async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Confirm Deletion'),
  //         content: const Text('Are you sure you want to delete your account? This action cannot be undone.'),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () => Navigator.of(context).pop(),
  //             child: const Text('Cancel'),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //               _deleteAccount();
  //             },
  //             child: const Text('Delete'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  Future<void> deleteAccount(context) async {
    EasyLoading.show(status: "Processing");
    try {
      if (selectedValue == null) {
        EasyLoading.dismiss();
        TLoaders.warningSnackBar(title: 'Warning', message: 'Select a reason');
        return;
      }
      // Call the delete account logic from UserController
      await _usercontroller.deleteAccount();
      EasyLoading.dismiss();
      // Show success message
      await SavedData.clearUserData();
      TLoaders.successSnackBar(title: 'Success', message: 'Account deleted successfully');
      // Navigate to SignInScreen
      Get.offAll(() => const SignInScreen());
    } catch (e) {
      // Handle errors
      EasyLoading.dismiss();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete account: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: TAppBar(
          showBackArrow: true,
          title: Text(
            "Delete Account",
            style: CustomTextStyles.text14wbold,
          ),
        ),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 18.h,
          ),
          child: Column(
            children: [
              SizedBox(
                width: 337.w,
                child: Text(
                  "If you delete this account you will no longer have access to this profile and all communications made on this platform, the account will be gone forever with no way to be restored ",
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: CustomTextStyles.text14w400.copyWith(
                    height: 1.43,
                  ),
                ),
              ),
              SizedBox(height: 27.h),
              DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  isExpanded: true,
                  hint: Text(
                    'Reason for delete',
                    style: CustomTextStyles.text12w400,
                    overflow: TextOverflow.ellipsis,
                  ),
                  items: items
                      .map((String item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: CustomTextStyles.text14w400,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                      .toList(),
                  value: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                    });
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
                    icon: const Icon(
                      Icons.expand_more,
                    ),
                    iconSize: 25.sp,
                    iconEnabledColor: Colors.grey,
                    iconDisabledColor: Colors.grey,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 200.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.w), bottomRight: Radius.circular(10.w)),
                      color: Colors.white,
                    ),
                    //offset: const Offset(0, 0),
                    scrollbarTheme: ScrollbarThemeData(
                      radius: Radius.circular(40.w),
                      thickness: WidgetStateProperty.all(6),
                      thumbVisibility: WidgetStateProperty.all(true),
                    ),
                  ),
                  menuItemStyleData: MenuItemStyleData(
                    height: 40.h,
                    padding: const EdgeInsets.only(left: 14, right: 14),
                  ),
                ),
              ),
              SizedBox(height: 53.h),
              Text(
                "Are you sure you want to delete this account?",
                style: CustomTextStyles.text14w400,
              ),
              SizedBox(height: 29.h),
              CustomElevatedButton(
                onPressed: () => deleteAccount(context),
                text: "Yes, delete",
                buttonStyle: CustomButtonStyles.fillRedTL25,
                buttonTextStyle: CustomTextStyles.text14w400.copyWith(color: TColors.white),
              ),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }
}

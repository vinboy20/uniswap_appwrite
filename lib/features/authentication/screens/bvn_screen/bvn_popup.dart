import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: unused_import
import 'package:get_storage/get_storage.dart';
import 'package:uniswap/common/widgets/button/custom_outlined_button.dart';
import 'package:uniswap/common/widgets/layouts/positioning_layout.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/features/authentication/screens/profile_form_screen/profile_form_screen.dart';

class BvnPopup extends StatelessWidget {
  const BvnPopup({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      margin: const EdgeInsets.all(0),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: SizedBox(
        height: 355.h,
        width: 342.w,
        child: PositioningLayout(
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 27),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("KYC Successful", style: CustomTextStyles.text14w400),
                  SizedBox(height: 29.h),
                  SizedBox(
                    width: 286.w,
                    child: Text(
                      "Notification will be sent to your mail($email) in a few minutes for the confirmation of your KYC",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: TSizes.spaceBtwSections),
                  CustomOutlinedButton(
                    width: 158.w,
                    height: 50.h,
                    text: "Ok",
                    buttonTextStyle: CustomTextStyles.text14w400cPrimary,
                    onPressed: () {
                      Get.to(() => const ProfileFormScreen());
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Widget buildKYCScreenPopup(BuildContext context, {required String email}) {

// }

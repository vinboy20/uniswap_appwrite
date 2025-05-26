
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniswap/common/widgets/button/custom_elevated_button.dart';
import 'package:uniswap/common/widgets/button/custom_outlined_button.dart';
import 'package:uniswap/common/widgets/form/custom_text_form_field.dart';
import 'package:uniswap/common/widgets/layouts/positioning_layout.dart';
import 'package:uniswap/controllers/database_controller.dart';
import 'package:uniswap/controllers/product_controller.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/core/utils/helpers/loaders.dart';
import 'package:uniswap/features/home/screens/wallet/widgets/withdrawal_sucessful_screen.dart';
import 'package:uniswap/theme/custom_button_style.dart';

class TopupWallet extends StatefulWidget {
  const TopupWallet({super.key});

  @override
  State<TopupWallet> createState() => _TopupWalletState();
}

class _TopupWalletState extends State<TopupWallet> {
  
 
  TextEditingController amountController = TextEditingController();

  final DatabaseController databaseController = Get.put(DatabaseController());
  final ProductController productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
      child: PositioningLayout(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.h),
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Amount to Top-up",
                style: CustomTextStyles.text14w400,
              ),
              SizedBox(height: 22.h),
              CustomTextFormField(
                controller: amountController,
                hintText: "₦",
                hintStyle: CustomTextStyles.text14w400,
                textInputAction: TextInputAction.done,
                maxLines: 1,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 15.h,
                ),
                borderDecoration: TextFormFieldStyleHelper.outlineOnErrorTL81,
                filled: true,
                // ignore: deprecated_member_use
                fillColor: theme.colorScheme.onPrimaryContainer.withOpacity(1),
              ),
              SizedBox(height: 38.h),
              CustomElevatedButton(
                  onPressed: () async {
                    final amount = double.tryParse(amountController.text.trim());
                    if (amount == null || amount <= 0) {
                      TLoaders.warningSnackBar(title: 'Warning', message: "please enter a valid amount to top-up");
                      return;
                    }
                     Get.to(() => WithdrawalSucessfulScreen());
                      Navigator.pop(context);
                    // await _processPayment(amount, context);
                  },
                  height: 38.h,
                  text: "Top-up Wallet",
                  buttonStyle: CustomButtonStyles.fillCyanTL7,
                  buttonTextStyle: CustomTextStyles.text14wbold),
              SizedBox(height: 21.h),
              CustomOutlinedButton(
                height: 38.h,
                onPressed: () {
                  Navigator.pop(context);
                },
                text: "Cancel",
                buttonStyle: CustomButtonStyles.outlinePrimaryTL7,
              ),
            ],
          ),
        ),
      ),
    );
  
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uniswap/common/widgets/button/custom_elevated_button.dart';
import 'package:uniswap/common/widgets/button/custom_icon_button.dart';
import 'package:uniswap/common/widgets/button/custom_outlined_button.dart';
import 'package:uniswap/common/widgets/form/custom_text_form_field.dart';
import 'package:uniswap/common/widgets/layouts/positioning_layout.dart';
import 'package:uniswap/common/widgets/wallet_success.dart';
import 'package:uniswap/controllers/product_controller.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/features/home/screens/wallet/widgets/topup_wallet.dart';
import 'package:uniswap/theme/custom_button_style.dart';

class WalletInfo extends StatefulWidget {
  const WalletInfo({super.key});

  @override
  State<WalletInfo> createState() => _WalletInfoState();
}

class _WalletInfoState extends State<WalletInfo> {
  TextEditingController amountController = TextEditingController();
  final ProductController productController = Get.find<ProductController>();
  int amount = 0;
  bool isAmountVisible = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE2E8F0),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50.w),
          bottomRight: Radius.circular(50.w),
        ),
        // color: appStore.whiteColor,
      ),
      child: PositioningLayout(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 20.h, bottom: 30.h),
            padding: EdgeInsets.symmetric(horizontal: 27.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 44.h,
                      height: 44.h,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFFFFFFF),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(width: 1, color: Color(0xFFE2E8F0)),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.notifications_outlined,
                          size: 24.sp,
                          color: TColors.gray200,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "Wallet Balance",
                  style: CustomTextStyles.text14wboldc19,
                ),
                SizedBox(height: 24.h),
                Container(
                  width: 230.w,
                  padding: const EdgeInsets.all(10),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFFFFFF),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 1, color: TColors.primary),
                      borderRadius: BorderRadius.circular(27),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        color: TColors.gray200,
                        onPressed: () {
                          setState(() {
                            isAmountVisible = !isAmountVisible; // Toggle visibility
                          });
                        },
                        icon: Icon(
                          isAmountVisible ? Icons.visibility : Icons.visibility_off, // Change icon based on visibility
                          size: 20.0,
                        ),
                      ),
                      SizedBox(width: 5.w),
                      Obx(() {
                        final wallets = productController.wallet;
                        if (wallets.isEmpty) return Text("₦0", style: CustomTextStyles.text18w600cPrimary);

                        amount = wallets.first.balance ?? 0;
                        return Text(
                          isAmountVisible ? NumberFormat.currency(locale: 'en_NG', symbol: '₦').format(amount) : '*****',
                          style: CustomTextStyles.text18w600cPrimary,
                        );
                      }),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 195.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => SimpleDialog(
                                  alignment: Alignment.center,
                                  children: [_withdraw(context)],
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                CustomIconButton(
                                  height: 56.h,
                                  width: 56.h,
                                  padding: EdgeInsets.all(18.w),
                                  decoration: IconButtonStyleHelper.fillBlueGrayTL28,
                                  child: CustomImageView(
                                    imagePath: TImages.arrowDown,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  "Withdraw",
                                  style: CustomTextStyles.text14w400cPrimary,
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => SimpleDialog(
                                  backgroundColor: Colors.white,
                                  // alignment: Alignment.center,
                                  contentPadding: EdgeInsets.zero,
                                  children: [TopupWallet()],
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                CustomIconButton(
                                  height: 56.h,
                                  width: 56.h,
                                  padding: const EdgeInsets.all(15),
                                  decoration: IconButtonStyleHelper.fillBlueGrayTL28,
                                  child: Icon(Icons.vertical_align_top_sharp, color: const Color(0xFFFF9300), size: 24.sp),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  "Top-Up",
                                  style: CustomTextStyles.text14w400cPrimary,
                                ),
                              ],
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
        ),
      ),
    );
  }



  /// Section Widget
  Widget _withdraw(BuildContext context) {
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
                "Amount to withdraw",
                style: CustomTextStyles.text14w400,
              ),
              SizedBox(height: 22.h),
              CustomTextFormField(
                controller: amountController,
                hintText: "₦",
                hintStyle: CustomTextStyles.text14w400,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.number,
                // maxLines: 2,
                contentPadding: EdgeInsets.only(
                  top: 12.h, left: 8.w, bottom: 12.h, right: 8.w,
                  // vertical: 8.h,
                ),

                borderDecoration: TextFormFieldStyleHelper.outlineOnErrorTL81,
                filled: true,
                fillColor: theme.colorScheme.onPrimaryContainer.withOpacity(1),
              ),
              SizedBox(height: 38.h),
              CustomElevatedButton(
                height: 38.h,
                text: "Withdraw From Wallet",
                buttonStyle: CustomButtonStyles.fillCyanTL7,
                buttonTextStyle: CustomTextStyles.text12w400,
                onPressed: () async {
                  EasyLoading.show();
                  // Get the amount from the TextFormField
                  String inputAmount = amountController.text;
                  // Parse the amount to an integer
                  int withdrawalAmount = int.tryParse(inputAmount.replaceAll(RegExp(r'[^\d]'), '')) ?? 0;

                  // Check if the withdrawal amount is valid and less than or equal to the available amount
                  if (withdrawalAmount > 0 && withdrawalAmount <= amount) {
                    setState(() {
                      amount -= withdrawalAmount; // Deduct the amount
                    });

                    // Simulate a delay and then close the dialog
                    await Future.delayed(const Duration(seconds: 1));
                    Navigator.pop(context); // Close the withdrawal dialog
                    EasyLoading.dismiss();

                    // Show success dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => SimpleDialog(
                        backgroundColor: Colors.white,
                        contentPadding: EdgeInsets.zero,
                        children: [walletSuccess(context, title: "Withdrawal Successfull")],
                      ),
                    );
                  } else {
                    EasyLoading.dismiss();
                    // Show an error message if the withdrawal amount is invalid
                    // You can use a dialog or a snackbar to show the error
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Invalid withdrawal amount')),
                    );
                  }
                },
              ),
              SizedBox(height: 21.h),
              CustomOutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                text: "Cancel",
                buttonStyle: CustomButtonStyles.outlinePrimaryTL7,
                height: 38.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

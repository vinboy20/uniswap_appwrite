import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uniswap/common/widgets/button/custom_elevated_button.dart';
import 'package:uniswap/common/widgets/form/custom_text_form_field.dart';
import 'package:uniswap/common/widgets/layouts/positioning_layout.dart';
import 'package:uniswap/common/widgets/payment_success_dialog.dart';
import 'package:uniswap/controllers/payment_controller.dart';
import 'package:uniswap/controllers/product_controller.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/features/shop/screen/input_pin_screen.dart';
import 'package:uniswap/theme/custom_button_style.dart';

class EscrowScreen extends StatelessWidget {
  const EscrowScreen({super.key, this.price, this.delieveryTime, this.delieveryDate, this.exchange, this.location, this.productId, this.sellerId});
  final String? price;
  final String? productId;
  final String? delieveryTime;
  final String? delieveryDate;
  final String? exchange;
  final String? location;
  final String? sellerId;
  
  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.put(ProductController());
    final PaymentController paymentController = Get.put(PaymentController());
    final TextEditingController pinController = TextEditingController();

    Future<void> processPayment(BuildContext context) async {
      final userId = await paymentController.getCurrentUserId();
      if (userId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User not authenticated')),
        );
        return;
      }

      // Verify PIN or biometric
      final pinVerified = await paymentController.verifyPin(
        userId,
        pinController.text,
      );

      if (!pinVerified) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid PIN or authentication failed')),
        );
        return;
      }

   final amount = double.tryParse(price ?? '') ?? 0;

    // Process payment
    final result = await paymentController.processPayment(
      buyerId: userId,
      sellerId: sellerId ?? "",
      amount: amount,
      productId: productId ?? '',
      deliveryDate: delieveryDate,
      deliveryTime: delieveryTime,
      exchange: exchange,
      location: location,
    );

    if (result['success'] as bool) {
      Navigator.of(context).pop(true); // Return success
      showDialog(
        context: context,
        builder: (_) => PaymentSuccessDialog(amount: amount),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'] as String)),
      );
    }
    }
    double walletBalance = 0;
    final productPrice = double.tryParse(price!);

    return PositioningLayout(
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        margin: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusStyle.roundedBorder10,
        ),
        child: Obx(() {
          final wallets = productController.wallet;
          if (wallets.isEmpty) return Text("₦0", style: CustomTextStyles.text18w600cPrimary);
          final wallet = wallets.first;
          // final wallet = wallets.firstWhere((wallet) => wallet.userId == userId, orElse: () => null);
          walletBalance = double.tryParse(wallet.balance) ?? 0;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    " Escrow Mode",
                    style: CustomTextStyles.text14w400,
                  ),
                ),
                SizedBox(height: 30.h),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 1.h),
                      child: Text(
                        "Wallet Balance",
                        style: CustomTextStyles.text14w400,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 40.w),
                      child: Text(
                        NumberFormat.currency(locale: 'en_NG', symbol: '₦').format(walletBalance),
                        style: CustomTextStyles.text14w400cPrimary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                Row(
                  children: [
                    Text(
                      "Amount to be paid",
                      style: CustomTextStyles.text14w400,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 14.w),
                      child: Text(
                        price != null ? NumberFormat.currency(locale: 'en_NG', symbol: '₦').format(double.tryParse(price!) ?? 0) : "₦0",
                        style: CustomTextStyles.text14w400cPrimary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 27.h),
                Padding(
                  padding: EdgeInsets.only(right: 26.w),
                  child: CustomTextFormField(
                    //controller: amountController,
                    hintText: price != null ? NumberFormat.currency(locale: 'en_NG', symbol: '₦').format(double.tryParse(price!) ?? 0) : "₦0",
                    hintStyle: CustomTextStyles.text14w600cPrimary,
                    textInputAction: TextInputAction.done,
                    enabled: false,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 11.w,
                      vertical: 8.h,
                    ),
                  ),
                ),
                SizedBox(height: 27.h),
                if (walletBalance >= productPrice!)
                  CustomElevatedButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) => SimpleDialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadiusStyle.roundedBorder10),
                          alignment: Alignment.center,
                          contentPadding: EdgeInsets.zero,
                          backgroundColor: const Color(0xFFFFFFFF),
                          children: [
                            InputPinScreen(
                              pincontroller: pinController,
                               validator: (value) {
                                if (value!.isEmpty) {
                                  return "code field is required";
                                } else if (value.length < 4 || value.length > 4) {
                                  return "max of 4 character is required";
                                }
                                return null;
                              },
                              title: "INPUT PIN",
                              description: "Input your 4-digit pin to continue",
                              buttonText: "Comfirm Payment",
                              onConfirm: () => processPayment(context),
                            )
                           
                          ],
                        ),
                      );
                    },
                    height: 39.h,
                    text: "Pay Seller ${price != null ? NumberFormat.currency(locale: 'en_NG', symbol: '₦').format(double.tryParse(price!) ?? 0) : "₦0"} ",
                    buttonStyle: CustomButtonStyles.fillPrimaryTL7,
                    buttonTextStyle: theme.textTheme.labelLarge!,
                  )
                else
                  CustomElevatedButton(
                    height: 39.h,
                    text: "Top Up",
                    buttonStyle: CustomButtonStyles.fillPrimaryTL7,
                    buttonTextStyle: theme.textTheme.labelLarge!,
                  ),
                SizedBox(height: 27.h),
              ],
            ),
          );
        }),
      ),
    );
  }
}

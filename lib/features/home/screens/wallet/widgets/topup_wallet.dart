import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniswap/common/widgets/button/custom_elevated_button.dart';
import 'package:uniswap/common/widgets/button/custom_outlined_button.dart';
import 'package:uniswap/common/widgets/form/custom_text_form_field.dart';
import 'package:uniswap/common/widgets/layouts/positioning_layout.dart';
import 'package:uniswap/controllers/database_controller.dart';
import 'package:uniswap/controllers/product_controller.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/core/utils/credentials.dart';
import 'package:uniswap/core/utils/helpers/loaders.dart';
import 'package:uniswap/data/saved_data.dart';
import 'package:uniswap/features/home/screens/wallet/widgets/withdrawal_sucessful_screen.dart';
import 'package:uniswap/models/transaction_model.dart';
import 'package:uniswap/theme/custom_button_style.dart';
import 'package:flutterwave_standard_smart/flutterwave.dart';
import 'package:monnify_payment_sdk/monnify_payment_sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TopupWallet extends StatefulWidget {
  const TopupWallet({super.key});

  @override
  State<TopupWallet> createState() => _TopupWalletState();
}

class _TopupWalletState extends State<TopupWallet> {
  late Monnify? monnify;

  final String txRef = "payment_${Random().nextInt(100000)}";

  final String _apiKey = dotenv.env['MONNIFY_API_KEY']!;
  final String _contractCode = dotenv.env['MONNIFY_CONTRACT_CODE']!;

  @override
  void initState() {
    super.initState();
    //initializeMonnify();
  }

  Future<void> initializeMonnify() async {
    await Monnify.initialize(
      applicationMode: ApplicationMode.TEST, // Change to LIVE in production
      apiKey: _apiKey,
      contractCode: _contractCode,
    );
  }

  TextEditingController amountController = TextEditingController();

  final DatabaseController databaseController = Get.put(DatabaseController());
  final ProductController productController = Get.find<ProductController>();
  // ignore: unused_element

  Future<void> _processPayment(double amount, context) async {
    // final userData = SavedData.getUserData();
    // if (userData == null || userData.isEmpty) {
    //   throw Exception("User data not found");
    // }

    // // Extract user details
    // final email = userData['email'] ?? '';
    // final username = userData['name'] ?? '';
    // final phone = userData['phone'] ?? '';
    // final userId = userData['userId'] ?? '';

    // Create customer object
    // final Customer customer = Customer(
    //   name: username,
    //   phoneNumber: phone,
    //   email: email,
    // );

    // Initialize Flutterwave payment
    // final Flutterwave flutterwave = Flutterwave(
    //   context: context,
    //   publicKey: "FLWPUBK_TEST-544a2d31219d73eb8d0ba168007571b2-X", // Use your public key
    //   currency: "NGN",
    //   txRef: txRef,
    //   amount: amount.toString(),
    //   customer: customer,
    //   paymentOptions: "card",
    //   customization: Customization(
    //     title: "Top-Up Wallet",
    //     description: "Top-Up Wallet",
    //   ),
    //   isTestMode: false,
    //   redirectUrl: "https://www.google.com",
    // );

    // Process payment
    // final ChargeResponse response = await flutterwave.charge();

    // final transaction = TransactionDetails().copyWith(
    //   amount: amount,
    //   currencyCode: 'NGN',
    //   customerName: 'Customer Name',
    //   customerEmail: 'custo.mer@email.com',
    //   paymentReference: '12wgg536eu',
    //   // metaData: {"ip": "0.0.0.0", "device": "mobile"},
    //   // paymentMethods: [PaymentMethod.CARD, PaymentMethod.ACCOUNT_TRANSFER, PaymentMethod.USSD],
    //   /*incomeSplitConfig: [SubAccountDetails("MFY_SUB_319452883968", 10.5, 500, true),
    //       SubAccountDetails("MFY_SUB_259811283666", 10.5, 1000, false)]*/
    // );
    // final response = await monnify?.initializePayment(transaction: transaction);

    // print(response);
    // Validate payment response
    // if (!response.success! || response.txRef != txRef) {
    //   Navigator.pop(context);
    //   TLoaders.errorSnackBar(title: 'Error', message: "Payment failed or transaction reference mismatch");
    // } else {
    //   // Retrieve wallet data

    //   final wallets = productController.wallet;
    //   if (wallets.isEmpty) {
    //     TLoaders.errorSnackBar(title: 'Error', message: "Error fetching wallet data");
    //     print("error fetching wallet data");
    //     return;
    //   }

    //   final wallet = wallets.firstWhere(
    //     (element) => element.userId == userData['userId'],
    //     orElse: () => TLoaders.errorSnackBar(title: 'Error', message: "Wallet not found for this user"),
    //   );

    //   // Calculate new balance
    //   final totalBalanceString = wallet.balance;
    //   final totalBalance = double.tryParse(totalBalanceString.toString()) ?? 0.0;
    //   final double newBalance = totalBalance + amount;
    //   final String newBalanceString = newBalance.toString();

    //   // Update wallet balance in the database
    //   await databaseController.updateData(
    //     {'balance': newBalanceString},
    //     Credentials.walletCollectionId,
    //     wallet.docId,
    //   );

    //   final newTransaction = TransactionModel(
    //     userId: userId,
    //     amount: amount.toString(),
    //     type: "topup",
    //     txRef: response.txRef ?? "",
    //     status: response.success! ? "success" : "failed",
    //   );
    //   await databaseController.createUserTransactions(newTransaction);
    //   // Show success message
    //   await productController.fetchWalletData(userId);
    //   await productController.fetchTransactionData(userId);
    //   await showDialog(
    //     context: context,
    //     builder: (BuildContext context) => SimpleDialog(
    //       shape: RoundedRectangleBorder(borderRadius: BorderRadiusStyle.roundedBorder10),
    //       alignment: Alignment.center,
    //       contentPadding: EdgeInsets.zero,
    //       backgroundColor: const Color(0xFFFFFFFF),
    //       children: [WithdrawalSucessfulScreen()],
    //     ),
    //   );
      // Get.to(() => WithdrawalSucessfulScreen());
      // Navigator.pop(context);
    // }
  }

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

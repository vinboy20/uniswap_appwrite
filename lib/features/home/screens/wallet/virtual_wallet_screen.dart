import 'package:get/get.dart';
import 'package:uniswap/controllers/monnify_controller.dart';
import 'package:uniswap/features/home/screens/wallet/widgets/wallet_info.dart';

import 'widgets/transfercomponent_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:uniswap/core/app_export.dart';

class VirtualWalletScreen extends StatefulWidget {
  const VirtualWalletScreen({super.key});

  @override
  State<VirtualWalletScreen> createState() => _VirtualWalletScreenState();
}

class _VirtualWalletScreenState extends State<VirtualWalletScreen> {
  TextEditingController amountController = TextEditingController();
  final controller = Get.put(MonnifyController());
  Future<void> _refreshPage() async {
    await controller.fetchWalletBalance();
    // Reload all data
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
           onRefresh: _refreshPage,
          child: Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(bottom: 30.h),
            //padding: EdgeInsets.symmetric(horizontal: 1.h),
            child: Column(
              children: [
                // Wallet Info
                const WalletInfo(),
                SizedBox(height: 25.h),
                Container(
                  padding: EdgeInsets.only(left: 27.h),
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Transactions",
                        style: CustomTextStyles.text16Bold,
                      ),
                      SizedBox(height: 3.h),
                      Container(
                        width: 50.h,
                        height: 2.h,
                        color: const Color(0XFF1CBE9C),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 18.h),
                const Expanded(
                  child: TransfercomponentItemWidget(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

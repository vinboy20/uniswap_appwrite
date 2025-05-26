import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniswap/controllers/monnify_controller.dart';
import 'package:uniswap/core/app_export.dart';

class TransfercomponentItemWidget extends StatelessWidget {
  const TransfercomponentItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MonnifyController());

    return Obx(() {
      if (controller.isLoadingTransactions.value) {
        return Center(child: CircularProgressIndicator());
      }

      if (controller.transactions.isEmpty) {
        return Center(child: Text('No transactions found'));
      }

      return Container(
        padding: EdgeInsets.symmetric(horizontal: 27.w),
        child: ListView.separated(
          itemCount: controller.transactions.length,
          separatorBuilder: (_, __) => SizedBox(height: 15.w),
          itemBuilder: (_, index) {
            final tx = controller.transactions[index];
            final isDebit = tx['transactionType'] == 'DEBIT';
            final isCredit = tx['transactionType'] == 'CREDIT';
            final isEscrow = tx['narration']?.toString().toLowerCase().contains('escrow') ?? false;

            return Row(
              children: [
                // Transaction Type Icon
                Container(
                  alignment: Alignment.center,
                  height: 40.h,
                  width: 40.w,
                  decoration: TAppDecoration.fillGray.copyWith(
                    borderRadius: BorderRadiusStyle.circleBorder28,
                  ),
                  child: isDebit
                      ? Icon(Icons.arrow_right_alt, color: const Color(0xFFEB5757), size: 14.sp)
                      : isCredit
                          ? Icon(Icons.import_export, color: const Color(0xFF29CC6A), size: 14.sp)
                          : Icon(Icons.vertical_align_top_sharp, color: const Color(0xFFFF9300), size: 14.sp),
                ),

                // Transaction Details
                Padding(
                  padding: EdgeInsets.only(left: 13.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isDebit
                            ? "Transfer"
                            : isCredit
                                ? "Received"
                                : "Top-up",
                        style: CustomTextStyles.text14w400,
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        controller.formatDate(tx['transactionDate']),
                        style: CustomTextStyles.text12w400.copyWith(color: TColors.gray200),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Amount and Status
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${isDebit ? '-' : '+'}${controller.formatAmount(tx['amount'])}',
                      style: isDebit
                          ? CustomTextStyles.text12w400cpink
                          : isCredit
                              ? CustomTextStyles.text12w400.copyWith(color: TColors.primary)
                              : CustomTextStyles.text12w400.copyWith(color: const Color(0xFFFF9300)),
                    ),
                    if (isEscrow)
                      Text(
                        "Escrow(Review)",
                        style: CustomTextStyles.text12w400.copyWith(color: TColors.primary),
                      ),
                  ],
                ),
              ],
            );
          },
        ),
      );
    });
  }
}

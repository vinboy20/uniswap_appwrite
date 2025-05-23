import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uniswap/controllers/product_controller.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/core/utils/formatters/formatter.dart';
import 'package:uniswap/data/saved_data.dart';

class TransfercomponentItemWidget extends StatelessWidget {
  const TransfercomponentItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.find<ProductController>();
    return Obx(
      () {
        if (controller.transaction.isEmpty) {
          return const Center(
            child: Text("No Transaction"),
          );
          // ignore: unrelated_type_equality_checks
        } else if (controller.isLoading == true) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 27.w),
            child: ListView.separated(
              itemCount: controller.transaction.length,
              separatorBuilder: (_, __) => SizedBox(height: 15.w),
              itemBuilder: (context, int index) {
                final transaction = controller.transaction[index];
                final amount = double.tryParse(transaction.amount ?? '0') ?? 0;

                final userId = SavedData.getUserId();
                
                final currentUserId = userId; // make sure you have this!
                final isBuyer = transaction.buyerId == currentUserId;
                final isSeller = transaction.sellerId == currentUserId;
                return Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 40.h,
                      width: 40.h,
                      decoration: TAppDecoration.fillGray.copyWith(
                        borderRadius: BorderRadiusStyle.circleBorder28,
                      ),
                      child: transaction.type == "topup"
                          ? Icon(Icons.vertical_align_top_sharp, color: const Color(0xFFFF9300), size: 14.sp)
                          : transaction.type == "transfer"
                              ? Icon(Icons.import_export, color: const Color(0xFFEB5757), size: 14.sp)
                              : Icon(
                                  Icons.vertical_align_top_sharp,
                                  color: Color(0xFF29CC6A),
                                  size: 14.sp,
                                ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 13.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(
                          //   transaction.type == "topup"
                          //       ? "Top-up"
                          //       : transaction.type == "transfer"
                          //           ? "Transfer"
                          //           : "Recieved",
                          //   style: CustomTextStyles.text14w400,
                          // ),
                          Text(
                            transaction.type == "topup"
                                ? "Top-up"
                                : isBuyer
                                    ? "Transfer"
                                    : isSeller
                                        ? "Received"
                                        : "Transaction",
                            style: CustomTextStyles.text14w400,
                          ),

                          SizedBox(height: 5.h),
                          Text(
                            // TFormatter.formattedDate(DateTime.parse(transaction.createdAt ?? "")),
                            TFormatter.formatDateTime(DateTime.parse(transaction.createdAt!)),
                            // transaction.createdAt ?? "",
                            style: CustomTextStyles.text12w400.copyWith(color: TColors.gray200),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Text(
                        //   "${transaction.type == "transfer" ? "-" : "+"} ${NumberFormat.currency(locale: 'en_NG', symbol: '₦').format(amount)}",
                        //   style: transaction.type == "transfer"
                        //       ? CustomTextStyles.text12w400cpink
                        //       : transaction.type == "topup"
                        //           ? CustomTextStyles.text12w400.copyWith(color: Color(0xFFFF9300))
                        //           : CustomTextStyles.text12w400.copyWith(color: TColors.primary),
                        // ),
                        Text(
                          "${isBuyer ? "-" : "+"} ${NumberFormat.currency(locale: 'en_NG', symbol: '₦').format(amount)}",
                          style: isBuyer
                              ? CustomTextStyles.text12w400cpink
                              : transaction.type == "topup"
                                  ? CustomTextStyles.text12w400.copyWith(color: Color(0xFFFF9300))
                                  : CustomTextStyles.text12w400.copyWith(color: TColors.primary),
                        ),

                        if (transaction.type == "escrow")
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
        }
      },
    );
  }
}

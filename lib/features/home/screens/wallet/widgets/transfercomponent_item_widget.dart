import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uniswap/controllers/product_controller.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/core/utils/formatters/formatter.dart';

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
        } else if (controller.isLoading == true) {
          //  return ListView.separated(
          //   itemCount: controller.transaction.length,
          //   separatorBuilder: (_, __) => SizedBox(height: 15.w),
          //   itemBuilder: (_, index) => Row(),
          // );
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
                 
                return Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 40.h,
                      width: 40.h,
                      // padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
                      decoration: TAppDecoration.fillGray.copyWith(
                        borderRadius: BorderRadiusStyle.circleBorder28,
                      ),

                      child: transaction.type == "topup" ? Icon(Icons.arrow_right_alt, color: const Color(0xFFFF9300), size: 14.sp)
                          : transaction.type == "transfer"
                              ? Icon(Icons.import_export, color: const Color(0xFFEB5757), size: 14.sp)
                              : Icon(Icons.vertical_align_top_sharp, color: Color(0xFF29CC6A), size: 14.sp),
                          // ? Icon(Icons.arrow_right_alt, color: const Color(0xFFEB5757), size: 14.sp)
                          // : index == 1
                          //     ? Icon(Icons.import_export, color: const Color(0xFF29CC6A), size: 14.sp)
                          //     : Icon(Icons.vertical_align_top_sharp, color: const Color(0xFFFF9300), size: 14.sp),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 13.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transaction.type == "topup"
                                ? "Top-up"
                                : transaction.type == "transfer"
                                    ? "Transfer"
                                    : "Recieved",
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
                        Text(
                           "₦${NumberFormat('#,##0', 'en_US').format(transaction.amount)}",
                          
                          style: transaction.type == "transfer"
                              ? CustomTextStyles.text12w400cpink
                              : transaction.type == "topup"
                                  ? CustomTextStyles.text12w400.copyWith(color:Color(0xFFFF9300) )
                                  : CustomTextStyles.text12w400.copyWith(color: TColors.primary),
                        ),
                        if (transaction.type == "recieved")
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uniswap/common/widgets/image_preview_widget.dart';
import 'package:uniswap/controllers/product_controller.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/core/utils/credentials.dart';
import 'package:uniswap/features/shop/screen/item_decription_screen/item_decription_screen.dart';

class OtherListing extends StatelessWidget {
  const OtherListing({super.key, this.userId});
  final String? userId;

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.put(ProductController());
    final allProduct = productController.products.where((user) => user.userId == userId).toList();

    final myProduct = allProduct.where((product) => product.isApproved == true).toList();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Other Listed Products",
                style: CustomTextStyles.text14wbold,
              ),
            ),
            Text(
              "View All",
              style: CustomTextStyles.text14w400cPrimary,
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Obx(() {
          if (productController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (myProduct.isEmpty) {
            return const Center(child: Text('No products available.'));
          }
          // return SizedBox(
          //   height: 120.h,
          //   // width: double.maxFinite,
          //   child: ListView.builder(

          //     // scrollDirection: Axis.horizontal,
          //     itemCount: myProduct.length,
          //     // itemCount: 2,
          //     itemBuilder: (_, index) {
          //       final product = myProduct[index];
          //       final List? images = product.image;
          //       return Padding(
          //         padding: const EdgeInsets.only(left: 20, right: 20),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             // if (images != null && images.isNotEmpty)
          //             //   FilePreviewImage(
          //             //     bucketId: Credentials.productBucketId,
          //             //     fileId: images[0],
          //             //     width: double.maxFinite,
          //             //     height: 116.h,
          //             //     isCircular: false,
          //             //     imageborderRadius: BorderRadius.only(
          //             //       topLeft: Radius.circular(10),
          //             //       topRight: Radius.circular(10),
          //             //     ),
          //             //   )
          //             // else
          //             //   const Placeholder(
          //             //     fallbackHeight: 116,
          //             //     fallbackWidth: double.maxFinite,
          //             //     color: Colors.grey,
          //             //   ),

          //             Padding(
          //               padding: EdgeInsets.only(left: 16.w, bottom: 6.h),
          //               child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Text(
          //                     product.productName ?? "",
          //                     style: CustomTextStyles.text14wbold.copyWith(
          //                       color: appTheme.gray90001,
          //                     ),
          //                   ),
          //                   SizedBox(height: 7.h),
          //                   Text(
          //                     "title",
          //                     style: theme.textTheme.labelLarge!.copyWith(
          //                       color: theme.colorScheme.onSecondaryContainer,
          //                     ),
          //                   ),
          //                   SizedBox(height: 19.h),
          //                   Text(
          //                     "time",
          //                     style: theme.textTheme.bodySmall!.copyWith(
          //                       color: theme.colorScheme.onError,
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ],
          //         ),
          //       );
          //     },
          //   ),
          // );

          return SizedBox(
            height: 205.h,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 180.h,
                crossAxisCount: 1,
                mainAxisSpacing: 0.h,
                crossAxisSpacing: 0.h,
              ),
              scrollDirection: Axis.horizontal,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: myProduct.length,
              itemBuilder: (context, index) {
                final product = myProduct[index];
                final List? images = product.image;

                return GestureDetector(
                  onTap: () {
                    Get.to(() => ItemDecriptionScreen(product: product));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(10.w),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 116.h,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              if (images != null && images.isNotEmpty)
                                FilePreviewImage(
                                  bucketId: Credentials.productBucketId,
                                  fileId: images[0],
                                  width: double.maxFinite,
                                  height: 116.h,
                                  isCircular: false,
                                  imageborderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                )
                              else
                                const Placeholder(
                                  fallbackHeight: 116,
                                  fallbackWidth: double.maxFinite,
                                  color: Colors.grey,
                                ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Padding(
                          padding: EdgeInsets.only(left: 6.w),
                          child: Row(
                            children: [
                              Text(
                                product.productName ?? "",
                                style: CustomTextStyles.text12w400,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                "(${product.productCondition ?? "N/A"})",
                                style: product.productCondition == "New" ? CustomTextStyles.text12w400cPrimary : CustomTextStyles.text12w400cpink,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 147.w,
                            child: const Divider(color: Color(0xFFE2E8F0)),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Padding(
                          padding: EdgeInsets.only(left: 6.w),
                          child: Text(
                            "₦${NumberFormat('#,##0', 'en_US').format(int.tryParse(product.startPrice ?? '0') ?? 0)}",
                            style: CustomTextStyles.text12wBold,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                product.location ?? "Unknown",
                                style: CustomTextStyles.text12w400,
                              ),
                              Icon(
                                Icons.location_on_outlined,
                                size: 18.sp,
                                color: TColors.gray200,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5.h),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }),
      ],
    );
  }
}

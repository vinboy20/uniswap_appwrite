import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uniswap/common/widgets/image_preview_widget.dart';
import 'package:uniswap/common/widgets/liked.dart';
import 'package:uniswap/common/widgets/loaders/shimmer.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/core/utils/credentials.dart';
import 'package:uniswap/core/utils/is_Expired_product.dart';
import 'package:uniswap/controllers/product_controller.dart';
import 'package:uniswap/features/shop/screen/item_decription_screen/item_decription_screen.dart';

class PopularProduct extends StatefulWidget {
  const PopularProduct({super.key});

  @override
  State<PopularProduct> createState() => _PopularProductState();
}

class _PopularProductState extends State<PopularProduct> {
  final controller = Get.put(ProductController());
  

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: 204.h,
            crossAxisCount: 2,
            mainAxisSpacing: 22,
            crossAxisSpacing: 22,
          ),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 2,
          itemBuilder: (context, index) {
            TShimmerEffect(
              width: double.maxFinite,
              height: 204.h,
            );
            return null;
          },
        );
      }

      if (controller.products.isEmpty) {
        return Center(child: Text('No products available'));
      }

      // Filter out expired products
      final activeProducts = controller.products.where((product) {
        return !isProductExpired(product.bidEndDate, product.bidEndTime);
      }).toList();

      if (activeProducts.isEmpty) {
        return Center(child: Text('No active products available'));
      }

       final myProduct = activeProducts.where((product) => product.isApproved == true).toList();

      return GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 204.h,
          crossAxisCount: 2,
          mainAxisSpacing: 22,
          crossAxisSpacing: 22,
        ),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: min(myProduct.length, 6),
        itemBuilder: (context, index) {
          final singleProduct = myProduct[index];
          final List? images = singleProduct.image;

          return GestureDetector(
            onTap: () {
              Get.to(() => ItemDecriptionScreen(product: singleProduct));
            },
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(10.w),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 116.h,
                    width: 159.w,
                    child: Stack(
                      alignment: Alignment.center,
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
                          ),
                        Liked(itemId: singleProduct.docId.toString()),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Padding(
                    padding: EdgeInsets.only(left: 6.w),
                    child: Row(
                      children: [
                        Text(
                          singleProduct.productName ?? "No Name",
                          style: CustomTextStyles.text12w400,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          "(${singleProduct.productCondition ?? "N/A"})",
                          style: singleProduct.productCondition == "New" ? CustomTextStyles.text12w400cPrimary : CustomTextStyles.text12w400cpink,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 147.w,
                      child: const Divider(
                        color: Color(0xFFE2E8F0),
                      ),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Container(
                    padding: EdgeInsets.only(left: 6.w),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "₦${NumberFormat('#,##0', 'en_US').format(int.tryParse(singleProduct.startPrice ?? '0') ?? 0)}",
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
                          singleProduct.location ?? "Unknown",
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
      );
    });
  }
}

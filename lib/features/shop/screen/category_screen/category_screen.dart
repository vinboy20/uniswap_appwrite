import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uniswap/common/widgets/appbar/appbar.dart';
import 'package:uniswap/common/widgets/image_preview_widget.dart';
import 'package:uniswap/common/widgets/liked.dart';
import 'package:uniswap/common/widgets/search/search_button_field.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/core/utils/credentials.dart';
import 'package:uniswap/controllers/product_controller.dart';
import 'package:uniswap/core/utils/is_Expired_product.dart';
import 'package:uniswap/features/shop/screen/item_decription_screen/item_decription_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key, required this.categoryId, required this.categoryTitle});

  final String categoryId;
  final String categoryTitle;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final ProductController productController = Get.put(ProductController());
 
  @override
  Widget build(BuildContext context) {
    final allProduct = productController.products.where((categoryId) => categoryId.catId == widget.categoryId).toList();
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const TAppBar(showBackArrow: true),
        body: Obx(() {
          if (productController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (allProduct.isEmpty) {
            return const Center(child: Text('No products available.'));
          }

          // Filter out expired products
          final activeProducts = allProduct.where((product) {
            return !isProductExpired(product.bidEndDate, product.bidEndTime);
          }).toList();

          if (activeProducts.isEmpty) {
            return Center(child: Text('No active products available'));
          }
          return Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // searchbar
                SearchButtonField(),
                
                SizedBox(height: 27.h),
                Text(widget.categoryTitle, style: CustomTextStyles.text14w600cPrimary),
                SizedBox(height: 19.h),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 204.h,
                      crossAxisCount: 2,
                      mainAxisSpacing: 22.h,
                      crossAxisSpacing: 22.h,
                    ),
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: activeProducts.length,
                    itemBuilder: (context, index) {
                      final product = activeProducts[index];
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
                                width: 159.w,
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
                                     Liked(itemId: product.docId.toString()),
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
                ),
                
                SizedBox(height: 19.h),
              ],
            ),
          );
        }),
      ),
    );
  }

}



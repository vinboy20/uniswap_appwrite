import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniswap/common/widgets/image_preview_widget.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/core/utils/credentials.dart';
import 'package:uniswap/controllers/product_controller.dart';
import 'package:uniswap/features/home/screens/home_container/home_container.dart';
import 'package:uniswap/features/shop/event/ticket_management_screen/ticket_management_screen.dart';
import 'package:uniswap/features/shop/screen/category_screen/category_screen.dart';

Widget categoryWidget(BuildContext context) {
  final ProductController productController = Get.put(ProductController());
  return Obx(() {
    if (productController.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }
    if (productController.categories.isEmpty) {
      return const Center(child: Text('No categories available.'));
    }
    return Row( 
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          height: 90.h,
          child: GestureDetector(
            onTap: () {
              Get.to(() => TicketManagementScreen());
            },
            child: Column(
              children: [
                CustomImageView(
                  imagePath: "assets/images/ticket-cat.png",
                  width: 25.h,
                  height: 25.h,
                ),
               
                SizedBox(height: 10.h),
                Text(
                  "Tickets",
                  softWrap: false,
                  style: TextStyle(fontSize: 12.sp, color: Color(0xFF94A3B8), fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Container(
          alignment: Alignment.center,
          height: 90.h,
          child: ListView.separated(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) {
              return SizedBox(width: 12.w);
            },
            itemCount: productController.categories.length,
            itemBuilder: (context, index) {
              final category = productController.categories[index];
              return GestureDetector(
                onTap: () {
                  if (category.docId != null) {
                    Get.to(() => CategoryScreen(categoryId: category.docId!, categoryTitle: category.title!));
                  }
                },
                child: Column(
                  children: [
                    Opacity(
                      opacity: 0.5,
                      child: FilePreviewImage(
                        bucketId: Credentials.categoryBucketId,
                        fileId: category.image!,
                        width: 25.h,
                        height: 25.h,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      category.title ?? "",
                      softWrap: false,
                      style: TextStyle(fontSize: 12.sp, color: Color(0xFF94A3B8), fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  });
}

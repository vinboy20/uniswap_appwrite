import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniswap/common/widgets/image_preview_widget.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/core/utils/credentials.dart';
import 'package:uniswap/controllers/product_controller.dart';
import 'package:uniswap/features/shop/event/ticket_screen/ticket_screen.dart';
import 'package:uniswap/features/shop/screen/category_screen/category_screen.dart';

Widget categoryWidget(BuildContext context) {
  final ProductController productController = Get.find<ProductController>();
  return Obx(() {
    if (productController.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    } else if (productController.categories.isEmpty) {
      return const Center(child: Text('No categories available.'));
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            height: 90.h,
            child: GestureDetector(
              onTap: () {
                Get.to(() => TicketScreen());
              },
              child: Column(
                children: [
                  CustomImageView(
                    imagePath: "assets/images/ticket-cat.png",
                    width: 25.h,
                    height: 25.h,
                  ),
                  SizedBox(height: 11.h),
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
                            
                        // ${import.meta.env.VITE_APPWRITE_ENDPOINT}/storage/buckets/${storageBucketId}/files/${uploadedFile.$id}/view?project=${import.meta.env.VITE_APPWRITE_PROJECT_ID}&project=${import.meta.env.VITE_APPWRITE_PROJECT_ID}&mode=admin`
                        // child: Image.network(
                        //   // "${Credentials.apiEndpoint}/storage/buckets/${Credentials.categoryBucketId}/files/${category.imageId}/view?project=${Credentials.projectID}&mode=admin",
                        //   category.image ?? '',
                        //   headers: {"Origin": "*"}, // Add this line
                        //   loadingBuilder: (context, child, loadingProgress) {
                        //     if (loadingProgress == null) return child;
                        //     return CircularProgressIndicator();
                        //   },
                        //   height: 25.h,
                        //   width: 25.w,
                        //   errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
                        // ),

                        child:  FilePreviewImage(
                          bucketId: Credentials.categoryBucketId,
                          fileId: category.imageId ?? '',
                          height: 25.h,
                         width: 25.w,
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
    }
  });
}

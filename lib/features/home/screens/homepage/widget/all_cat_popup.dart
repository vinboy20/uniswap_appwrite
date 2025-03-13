import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';
import 'package:uniswap/common/widgets/custom_dash_line_painter.dart';
import 'package:uniswap/common/widgets/image_preview_widget.dart';
import 'package:uniswap/controllers/product_controller.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/core/utils/credentials.dart';
import 'package:uniswap/features/shop/screen/subcategory_screen/subcategory_screen.dart';

class AllCatWidget extends StatelessWidget {
  const AllCatWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.put(ProductController());
    final categories = productController.categories;
    final subcategories = productController.subcategories;
    return Container(
      height: THelperFunctions.screenHeight(),
      width: THelperFunctions.screenWidth(),
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Shop by Category",
                    style: CustomTextStyles.text14w600cPrimary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: SizedBox(
              child: ListView.builder(
                itemCount: categories.length,
                scrollDirection: Axis.vertical,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  // Filter subcategories based on catId
                  final categorySubcategories = subcategories.where((sub) => sub.catId == category.docId).toList();
                  return Column(
                    children: [
                      SizedBox(
                        child: GFAccordion(
                          titleChild: Row(
                            children: [
                              Opacity(
                                opacity: 0.5,
                                child: FilePreviewImage(
                                  bucketId: Credentials.categoryBucketId,
                                  fileId: category.image!,
                                  width: 20.w,
                                  height: 20.h,
                                  borderRadius: 0.0,
                                  isCircular: true,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(category.title ?? "No Title"),
                            ],
                          ),
                          collapsedTitleBackgroundColor: Colors.transparent,
                          contentChild: ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: categorySubcategories.length, // Filtered count
                            separatorBuilder: (BuildContext context, index) => SizedBox(
                              height: 10.h,
                            ),
                            itemBuilder: (BuildContext context, index) {
                               var subcat = categorySubcategories[index];
                              return GestureDetector(
                                onTap: () {
                                  Get.to(() => SubCategoryScreen(subcategoryId: subcat.docId!, subcategoryTitle: subcat.title!));
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  child: Text(subcat.title ?? "No Title"),
                                ),
                              );
                            },
                          ),
                          collapsedIcon: Icon(
                            Icons.keyboard_arrow_down,
                            size: 18.sp,
                          ),
                          expandedIcon: Icon(
                            Icons.keyboard_arrow_up,
                            size: 18.sp,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1.0, // Thickness of the dashed line
                        width: double.infinity,
                        child: CustomPaint(
                          painter: CustomDashLinePainter(
                            dashWidth: 5.0.w,
                            dashSpace: 3.0.h,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

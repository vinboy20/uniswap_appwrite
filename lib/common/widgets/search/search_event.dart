import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uniswap/common/widgets/appbar/appbar.dart';
import 'package:uniswap/common/widgets/form/custom_search_view.dart';
import 'package:uniswap/common/widgets/image_preview_widget.dart';
import 'package:uniswap/common/widgets/liked.dart';
import 'package:uniswap/controllers/product_controller.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/core/utils/credentials.dart';
import 'package:uniswap/features/shop/screen/item_decription_screen/item_decription_screen.dart';
import 'package:uniswap/models/product_model.dart';

class SearchEvent extends StatefulWidget {
  const SearchEvent({super.key});

  @override
  State<SearchEvent> createState() => _SearchEventState();
}

class _SearchEventState extends State<SearchEvent> {
  final TextEditingController searchController = TextEditingController();
  final ProductController productController = Get.put(ProductController());
  List<ProductModel> searchResults = [];

  void searchProducts(String value) async {
    if (value.isNotEmpty) {
      final results = await productController.searchProducts(value);
      setState(() {
        searchResults = results;
      });
    } else {
      setState(() {
        searchResults = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: const TAppBar(showBackArrow: true),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        child: Column(
          children: [
            CustomSearchView(
              controller: searchController,
              onChanged: searchProducts, // Calls searchProducts function on input
              borderDecoration: OutlineInputBorder(
                borderSide: const BorderSide(color: TColors.softGrey),
                borderRadius: BorderRadius.circular(50.w),
              ),
              autofocus: false,
              hintText: "Search",
              contentPadding: EdgeInsets.symmetric(vertical: 19.h),
              fillColor: TColors.softGrey,
            ),
            SizedBox(height: 27.h),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 204.h,
                  crossAxisCount: 2,
                  mainAxisSpacing: 22.h,
                  crossAxisSpacing: 22.h,
                ),
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  final product = searchResults[index];
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
                                  "(${product.productCondition})",
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
                                  product.location ?? "",
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
          ],
        ),
      ),
    );
  }
}

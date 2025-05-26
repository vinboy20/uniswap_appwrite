import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uniswap/common/widgets/button/custom_elevated_button.dart';
import 'package:uniswap/common/widgets/button/custom_icon_button.dart';
import 'package:uniswap/common/widgets/image_preview_widget.dart';
import 'package:uniswap/controllers/product_controller.dart';
import 'package:uniswap/controllers/wishlist_controller.dart';
import 'package:uniswap/core/utils/credentials.dart';
import 'package:uniswap/core/utils/helpers/obx_widget.dart';
import 'package:uniswap/features/home/screens/home_container/widgets/drawer_widget.dart';
import 'package:uniswap/features/shop/screen/my_wish_list_screen/widgets/no_wishlist.dart';
import 'package:uniswap/theme/custom_button_style.dart';
import 'package:flutter/material.dart';
import 'package:uniswap/core/app_export.dart';

class MyWishListScreen extends StatefulWidget {
  const MyWishListScreen({super.key});

  @override
  State<MyWishListScreen> createState() => _MyWishListScreenState();
}

class _MyWishListScreenState extends State<MyWishListScreen> {
  final controller = Get.find<ProductController>();
  final wishcontroller = Get.put(WishController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "My Wishlist",
            style: CustomTextStyles.text14wbold,
          ),
          centerTitle: true,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.notes_sharp), // Your custom icon
                onPressed: () {
                  Scaffold.of(context).openDrawer(); // Open the drawer
                },
              );
            },
          ),
        
        ),
        drawer: Drawer(
          width: 271.w,
          child: DrawerWidget(),
        ),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              obxWidget(
                isLoading: wishcontroller.isLoading,
                dataList: wishcontroller.wishlistProducts, 
                emptyWidget: noWishlist(context),
                child: _buildProductWishlist(context),
              ),
              SizedBox(height: 33.h),
              Card(
                clipBehavior: Clip.antiAlias,
                elevation: 0,
                color: appTheme.indigo50,
                shape: RoundedRectangleBorder(borderRadius: BorderRadiusStyle.roundedBorder10),
                child: Container(
                  height: 131.h,
                  width: 253.w,
                  decoration: TAppDecoration.fillIndigo.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder10,
                  ),
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          height: 121.h,
                          width: 133.w,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Opacity(
                                opacity: 0.7,
                                child: CustomImageView(
                                  imagePath: TImages.flower,
                                  height: 121.h,
                                  width: 133.w,
                                  alignment: Alignment.center,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 8.h, right: 8.w),
                                child: CustomIconButton(
                                  height: 25.h,
                                  width: 25.w,
                                  padding: EdgeInsets.all(5.w),
                                  decoration: IconButtonStyleHelper.softGray,
                                  alignment: Alignment.topRight,
                                  child: Icon(
                                    Icons.favorite,
                                    color: const Color(0xFFE11D48),
                                    size: 16.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 11.w),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 143.w,
                              child: Text(
                                "The Old Black Peoples Movement",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: CustomTextStyles.text12wBold.copyWith(height: 1.56),
                              ),
                            ),
                            SizedBox(height: 9.h),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("By TB. tribe", style: CustomTextStyles.text12wBold),
                                SizedBox(
                                  width: 16.w,
                                ),
                                Text("July 20th 8:00PM", style: CustomTextStyles.text12w400)
                              ],
                            ),
                            SizedBox(height: 9.h),
                            CustomElevatedButton(
                              height: 20.h,
                              width: 124.w,
                              text: "Get Ticket",
                              buttonStyle: CustomButtonStyles.fillPrimaryTL3,
                              buttonTextStyle: CustomTextStyles.text12w400,
                              onPressed: () {
                                // Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.ticketUploadScreen);
                              },
                              alignment: Alignment.center,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildProductWishlist(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 225.h,
          crossAxisCount: 2,
          mainAxisSpacing: 22.w,
          crossAxisSpacing: 22.w,
        ),
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: wishcontroller.wishlistProducts.length,
        itemBuilder: (context, index) {
          final product = wishcontroller.wishlistProducts[index];
          final allProduct = controller.products.where((productId) => productId.docId == product.docId).toList();
          final wishProduct = allProduct[index];
          final List? images = wishProduct.image;
          return Column(
            children: [
              // CustomImageView(
              //   imagePath: TImages.lamp,
              //   height: 112.h,
              //   width: double.maxFinite,
              //   radius: BorderRadius.vertical(
              //     top: Radius.circular(8.w),
              //   ),
              // ),
              if (images != null && images.isNotEmpty)
                FilePreviewImage(
                  bucketId: Credentials.productBucketId,
                  fileId: images[0],
                  width: double.maxFinite,
                  height: 112.h,
                  isCircular: false,
                  imageborderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),

              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 12.h,
                ),
                decoration: TAppDecoration.fillGray,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          wishProduct.productName ?? "",
                          style: theme.textTheme.bodyMedium,
                        ),
                        Text(
                          "₦${NumberFormat('#,##0', 'en_US').format(int.tryParse(wishProduct.startPrice ?? '0') ?? 0)}",
                          style: CustomTextStyles.text14wbold,
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "fairly ${wishProduct.productCondition ?? "N/A"}",
                      style: CustomTextStyles.text12wBold.copyWith(color: const Color(0xFF94A3B8)),
                    ),
                    SizedBox(height: 9.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          wishProduct.location ?? "Unknown",
                          style: CustomTextStyles.text12wBold.copyWith(color: const Color(0xFF94A3B8)),
                        ),
                        CustomImageView(
                          imagePath: ImageConstant.imgSearchBlueGray500,
                          height: 20.h,
                          width: 20.h,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

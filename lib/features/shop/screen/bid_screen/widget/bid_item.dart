import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uniswap/common/widgets/button/custom_elevated_button.dart';
import 'package:uniswap/common/widgets/button/custom_outlined_button.dart';
import 'package:uniswap/common/widgets/image_preview_widget.dart';
import 'package:uniswap/common/widgets/layouts/positioning_layout.dart';
import 'package:uniswap/controllers/product_controller.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/core/utils/credentials.dart';
import 'package:uniswap/core/utils/formatters/formatter.dart';
import 'package:uniswap/core/utils/helpers/loaders.dart';
import 'package:uniswap/features/shop/screen/bid_item_payment_screen/bid_item_payment_screen.dart';
import 'package:uniswap/features/shop/screen/bid_screen/widget/time_bid.dart';
import 'package:uniswap/features/shop/screen/item_decription_screen/item_decription_screen.dart';
import 'package:uniswap/models/bid_model.dart';
import 'package:uniswap/models/product_model.dart';
import 'package:uniswap/theme/custom_button_style.dart';

class BidItem extends StatefulWidget {
  const BidItem({super.key, required this.bid});

  // final ProductModel? product;
  final BidModel bid;
  

  @override
  State<BidItem> createState() => _BidItemState();
}

class _BidItemState extends State<BidItem> {
  final ProductController productController = Get.find<ProductController>();

  double? _highestBid;

  // Fetch the highest bid
  ProductModel? product;

  @override
  void initState() {
    super.initState();
    product = productController.products.firstWhereOrNull(
      (element) => element.docId == widget.bid.productId,
    );
    _fetchBidData(); // Call this after product is initialized
  }

  Future<void> _fetchBidData() async {
    // Fetch the highest bid
    final productId = product!.docId;
    final highestBid = await productController.getHighestBid(productId ?? ""); // Pass the productId
    if (highestBid != null) {
      setState(() {
        _highestBid = highestBid; // Default to 0.0 if highestBid is null
      });
    } else {
      setState(() {
        _highestBid = 0.0; // Default to 0.0 if there are no bids
      });
    }
  }

 

  //   // Method to check bid status
  String _getBidStatus(ProductModel? product, BidModel bid, double? highestBid) {
    if (product == null) return "Countdown";

    try {
      // Parse the date and time strings
      final dateFormat = DateFormat('dd/MM/yyyy hh:mm a'); // Format for "19/02/2025 6:30 PM"
      final bidEndDateTime = dateFormat.parse("${product.bidEndDate} ${product.bidEndTime}");
      final currentDateTime = DateTime.now();

      // Check if the bid has expired
      if (currentDateTime.isAfter(bidEndDateTime)) {
        if (bid.amount != null && bid.amount! < (highestBid ?? 0.0)) {
          return "BidLost";
        } else {
          return "BidWon";
        }
      } else {
        // Bid is still active
        return "Countdown";
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: "Error", message: e.toString());
      debugPrint("Error parsing date/time: $e");
      return "Countdown"; // Fallback in case of parsing errors
    }
  }

  @override
  Widget build(BuildContext context) {
    // final ProductModel? product = productController.products.firstWhereOrNull((element) => element.docId == widget.bid.productId);
    final bidStatus = _getBidStatus(product, widget.bid, _highestBid);
    return Column(
      children: [
        if (bidStatus == "BidWon")
          bidwon(
            context,
            image: product?.image?.isNotEmpty == true ? product!.image![0] : "",
            won: CustomImageView(
              imagePath: "assets/images/bid_won.png",
              width: 100.w,
              height: 20.h,
              radius: BorderRadius.circular(20),
            ),
          ),
        if (bidStatus == "BidLost")
          bidlost(
            context,
            image: product?.image?.isNotEmpty == true ? product!.image![0] : "",
            timeLeft: "Time left",
            time: TimeBid(
              time: product?.bidEndTime,
              date: product?.bidEndDate,
            ),
            lost: CustomImageView(
              imagePath: "assets/images/bid_lost.png",
              width: 100.w,
              height: 20.h,
              radius: BorderRadius.circular(20),
            ),
          ),
        if (bidStatus == "Countdown")
          _buildImage(
            context,
            image: product?.image?.isNotEmpty == true ? product!.image![0] : "",
            timeLeft: "Time left",
            time: TimeBid(
              time: product?.bidEndTime,
              date: product?.bidEndDate,
            ),
          ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 11.h),
          decoration: TAppDecoration.fillGray,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 3.h),
                    child: Text(
                      TFormatter.formattedStringPrice(product?.startPrice),
                      style: CustomTextStyles.text12wBold.copyWith(
                        color: theme.colorScheme.onSecondaryContainer,
                      ),
                    ),
                  ),
                  Text(
                    product?.productName ?? 'N/A',
                    style: CustomTextStyles.text12wBold.copyWith(
                      color: theme.colorScheme.onSecondaryContainer,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 9.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 3.h),
                    child: Text(
                      "Current Bid",
                      style: CustomTextStyles.text12w400.copyWith(
                        color: theme.colorScheme.onSecondaryContainer,
                      ),
                    ),
                  ),
                  Text(
                    "My Bid",
                    style: CustomTextStyles.text14wbold.copyWith(
                      color: TColors.primary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 9.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 3.h),
                    child: Text(
                      //   "₦${NumberFormat('#,##0', 'en_US').format(_highestBid)}",
                      "₦${NumberFormat('#,##0', 'en_US').format(_highestBid)}",
                      style: CustomTextStyles.text12w400.copyWith(
                        color: theme.colorScheme.onSecondaryContainer,
                      ),
                    ),
                  ),
                  Text(
                    "₦${NumberFormat('#,##0', 'en_US').format(widget.bid.amount)}",
                    style: CustomTextStyles.text12w400.copyWith(
                      color: theme.colorScheme.onSecondaryContainer,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 9.h),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        if (bidStatus == "BidWon")
          CustomElevatedButton(
            onPressed: () {
              // Navigate to payment screen
              Get.to(() => BidItemPaymentScreen(product: product, highestBid: _highestBid));
              // if (product != null) {
              //   Get.to(() => ItemDecriptionScreen(product: product!, highestBid: _highestBid));
              // } else {
              //   TLoaders.errorSnackBar(title: "Error", message: "Product not found.");
              // }
            },
            height: 25.54.h,
            width: 156.w,
            text: "Pay Now",
            buttonStyle: CustomButtonStyles.fillCyan,
            buttonTextStyle: CustomTextStyles.text14wbold,
          ),
        if (bidStatus == "Countdown" || bidStatus == "BidLost")
          CustomElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => SimpleDialog(
                  alignment: Alignment.center,
                  contentPadding: EdgeInsets.zero,
                  children: [
                    Container(
                      height: 300.h,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                      child: PositioningLayout(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 223.w,
                                child: Text(
                                  "Are you sure you want to remove your bid?",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: CustomTextStyles.text14wbold.copyWith(
                                    height: 1.50,
                                  ),
                                ),
                              ),
                              SizedBox(height: 32.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    height: 39.h,
                                    width: 115.w,
                                    text: "No, leave bid",
                                    buttonTextStyle: CustomTextStyles.text14wbold,
                                    buttonStyle: CustomButtonStyles.fillCyanTL7,
                                  ),
                                  CustomOutlinedButton(
                                    onPressed: () async {
                                      Navigator.pop(context); // Close the dialog
                                      await productController.deleteBid(widget.bid.docId!);
                                    },
                                    width: 115.w,
                                    height: 39.h,
                                    text: "Yes, remove bid ",
                                    margin: EdgeInsets.only(left: 23.w),
                                    buttonTextStyle: CustomTextStyles.text14wbold,
                                    buttonStyle: CustomButtonStyles.outlinePrimary1,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
            height: 25.54.h,
            width: 156.w,
            text: "Remove Bid",
            buttonStyle: CustomButtonStyles.fillCyan,
            buttonTextStyle: CustomTextStyles.text14wbold,
          ),
      ],
    );
  }

  /// Common widget
  Widget _buildImage(
    BuildContext context, {
    required String timeLeft,
    required String image,
    required Widget time,
  }) {
    return GestureDetector(
      onTap: () {
        // Get.off( () => ItemDecriptionScreen());
      },
      child: Container(
        height: 95.87.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusStyle.customBorderTL8,
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // if (images != null && images.isNotEmpty)
            FilePreviewImage(
              bucketId: Credentials.productBucketId,
              fileId: image,
              width: double.maxFinite,
              height: 116.h,
              isCircular: false,
              imageborderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                decoration: TAppDecoration.gradientBlackToBlack900,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      timeLeft,
                      style: CustomTextStyles.text12w400.copyWith(
                        color: appTheme.pink600,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    time,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Common widget
  Widget bidlost(
    BuildContext context, {
    required String timeLeft,
    required String image,
    required Widget time,
    required Widget lost,
  }) {
    return GestureDetector(
      onTap: () {
        // Get.off(const BidItemPaymentScreen());
      },
      child: Container(
        height: 95.87.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusStyle.customBorderTL8,
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // if (images != null && images.isNotEmpty)
            FilePreviewImage(
              bucketId: Credentials.productBucketId,
              fileId: image,
              width: double.maxFinite,
              height: 116.h,
              isCircular: false,
              imageborderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                decoration: TAppDecoration.gradientBlackToBlack900,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      timeLeft,
                      style: CustomTextStyles.text12w400.copyWith(
                        color: appTheme.pink600,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    time,
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                decoration: TAppDecoration.gradientBlackToBlack900,
                child: lost,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Common widget
  Widget bidwon(
    BuildContext context, {
    required String image,
    required Widget won,
  }) {
    return GestureDetector(
      onTap: () {
        // Get.off(const BidItemPaymentScreen());
      },
      child: Container(
        height: 95.87.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusStyle.customBorderTL8,
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // if (images != null && images.isNotEmpty)
            FilePreviewImage(
              bucketId: Credentials.productBucketId,
              fileId: image,
              width: double.maxFinite,
              height: 116.h,
              isCircular: false,
              imageborderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                decoration: TAppDecoration.gradientBlackToBlack900,
                child: won,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Common widget
}

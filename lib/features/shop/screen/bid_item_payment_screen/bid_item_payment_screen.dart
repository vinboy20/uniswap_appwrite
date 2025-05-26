import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uniswap/common/widgets/appbar/appbar.dart';
import 'package:uniswap/common/widgets/button/custom_outlined_button.dart';
import 'package:uniswap/common/widgets/image_preview_widget.dart';
import 'package:uniswap/common/widgets/loaders/shimmer.dart';
import 'package:uniswap/controllers/user_controller.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/core/utils/credentials.dart';
import 'package:uniswap/core/utils/helpers/loaders.dart';
import 'package:uniswap/data/saved_data.dart';
import 'package:uniswap/features/personalization/screen/profile_screen/profile_screen.dart';
import 'package:uniswap/features/shop/screen/escrow_request_screen/escrow_request_screen.dart';
import 'package:uniswap/models/user.dart';
import 'package:uniswap/controllers/product_controller.dart';

class BidItemPaymentScreen extends StatefulWidget {
  const BidItemPaymentScreen({super.key, required this.product, required this.highestBid});

  final dynamic product;
  final double? highestBid;

  @override
  State<BidItemPaymentScreen> createState() => _BidItemPaymentScreenState();
}

class _BidItemPaymentScreenState extends State<BidItemPaymentScreen> {
  final controller = Get.find<ProductController>();
  final userController = Get.put(UserController());

  UserModel? _userDetails;
  bool isLiked = false;
  int sliderIndex = 0;

  bool? isBid;

  @override
  void initState() {
    super.initState();
    // Fetch user details when the screen is initialized
    _fetchUserDetails();
  }

  void shareContent() {
    String text = 'Check out this amazing product!';
    String link = 'https://example.com/product/123';
    String shareText = '$text\n$link';

    Share.share(shareText);
  }

 Future<void> _fetchUserDetails() async {
    try {
      final user = await userController.getUserById(widget.product.userId ?? '');
      setState(() {
        _userDetails = user;
      });
    } catch (e) {
      TLoaders.errorSnackBar(
        title: "Error",
        message: e.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final List? images = widget.product.image;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: TAppBar(
          showBackArrow: true,
          leadingOnPressed: () {
            Navigator.pop(context);
          },
          actions: [
            IconButton(
              onPressed: () => shareContent(),
              icon: const Icon(Icons.share),
            ),
          ],
        ),
        body: SizedBox(
          width: THelperFunctions.screenWidth(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 241.h,
                  width: THelperFunctions.screenWidth(),
                  child: CarouselSlider.builder(
                    options: CarouselOptions(
                      height: 241.h,
                      initialPage: 0,
                      reverse: false,
                      pageSnapping: true,
                      viewportFraction: 1.0,
                      enableInfiniteScroll: false,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (index, reason) {
                        sliderIndex = index;
                      },
                    ),
                    itemCount: images?.length,
                    itemBuilder: (context, index, realIndex) {
                      return FilePreviewImage(
                        bucketId: Credentials.productBucketId,
                        fileId: images?[index],
                        width: double.maxFinite,
                        height: 241.h,
                        isCircular: false,
                        imageborderRadius: BorderRadius.zero,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: TSizes.lg),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.product.productName.toString(),
                            style: CustomTextStyles.text20bold,
                          ),
                          Text(
                            "₦${NumberFormat('#,##0', 'en_US').format(widget.highestBid)}",
                            style: CustomTextStyles.text14w600cPrimary,
                          ),
                        ],
                      ),
                      SizedBox(height: 29.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Description",
                          style: CustomTextStyles.text14w600cPrimary,
                        ),
                      ),
                      SizedBox(height: 13.h),
                      ReadMoreText(
                        widget.product.description.toString(),
                        trimMode: TrimMode.Line,
                        colorClickableText: TColors.primary,
                        trimCollapsedText: 'more detail',
                        trimExpandedText: 'Show less',
                        style: CustomTextStyles.text14w400,
                      ),
                      SizedBox(height: 16.h),
                      const Divider(),
                      GFAccordion(
                        margin: EdgeInsets.zero,
                        titleChild: Text(
                          textAlign: TextAlign.start,
                          'More Specification',
                          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                        ),
                        collapsedTitleBackgroundColor: Colors.transparent,
                        content:
                            (widget.product.moreSpec == null || widget.product.moreSpec!.isEmpty) ? 'No spec available' : widget.product.moreSpec.toString(),
                        collapsedIcon: Icon(
                          Icons.keyboard_arrow_down,
                          size: 16.sp,
                        ),
                        expandedIcon: Icon(
                          Icons.keyboard_arrow_up,
                          size: 16.sp,
                        ),
                      ),
                      const Divider(),
                      SizedBox(height: 24.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Contact Swapper ",
                          style: CustomTextStyles.text14w600cPrimary,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      if (_userDetails != null)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 8,
                                  children: [
                                    _userDetails!.photo.toString().isNotEmpty
                                        ?
                                    FilePreviewImage(
                                            bucketId: Credentials.userBucketId,
                                            fileId: _userDetails!.photo ?? '',
                                            height: 52.h,
                                            width: 52.w,
                                          )
                                        : CustomImageView(
                                            imagePath: _userDetails!.avatar, // Default profile image
                                            height: 52.h,
                                            width: 52.w,
                                            radius: BorderRadius.circular(50.w),
                                          ),
                                    Text(
                                      _userDetails!.name ?? "Unknown",
                                      style: CustomTextStyles.text14w600cPrimary,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Get.to(() => ProfileScreen(userData: _userDetails));
                                      },
                                      child: Text(
                                        'View profile',
                                        style: CustomTextStyles.text14w400cBlue,
                                      ),
                                    ),
                                    const Icon(Icons.chevron_right)
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 5.h),
                            Row(
                              children: [
                                Text(
                                  "Phone number:",
                                  style: CustomTextStyles.text14w400,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 16.w),
                                  child: Text(
                                    _userDetails!.phone ?? "N/A",
                                    style: CustomTextStyles.text14w400cBlue,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h),
                            Row(
                              children: [
                                Text(
                                  "Location:",
                                  style: CustomTextStyles.text14w400,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 16.w),
                                  child: Text(
                                    _userDetails!.address ?? "Unknown",
                                    style: CustomTextStyles.text14w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      else
                        Center(
                          child: TShimmerEffect(
                            width: double.maxFinite,
                            height: 100.h,
                          ), // Show a loader while fetching user details
                        ),
                      SizedBox(height: 32.h),
                      CustomOutlinedButton(
                        text: "Make Payment",
                        buttonStyle: TAppDecoration.softDark,
                        buttonTextStyle: CustomTextStyles.text14w400cPrimary,
                        onPressed: () async {
                           final user = SavedData.getUserData();
                          if (user == null) {
                            TLoaders.errorSnackBar(
                              title: "Error",
                              message: "Please login to make payment",
                            );
                            return;
                          }
                          if (user['isValidated'] == false) {
                            TLoaders.errorSnackBar(
                              title: "Error",
                              message: "Your account is not validated. Please contact support.",
                            );
                            return;
                          }
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) => SimpleDialog(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadiusStyle.roundedBorder10),
                              alignment: Alignment.center,
                              contentPadding: EdgeInsets.zero,
                              backgroundColor: const Color(0xFFFFFFFF),
                              children: [EscrowRequestScreen(price: widget.highestBid.toString(), productId: widget.product.docId.toString(), sellerId: _userDetails!.docId)],
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

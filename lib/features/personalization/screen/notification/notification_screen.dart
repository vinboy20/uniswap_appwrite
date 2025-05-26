import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:uniswap/common/widgets/button/custom_elevated_button.dart';
import 'package:uniswap/common/widgets/button/custom_outlined_button.dart';
import 'package:uniswap/common/widgets/images/image_url.dart';
import 'package:uniswap/common/widgets/notification/notifications.dart';
import 'package:uniswap/controllers/product_controller.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/core/utils/formatters/formatter.dart';
import 'package:uniswap/features/home/screens/home_container/widgets/drawer_widget.dart';
import 'package:uniswap/features/personalization/screen/appeal_screen/appeal_screen.dart';
import 'package:uniswap/features/shop/screen/input_pin_screen.dart';
import 'package:uniswap/models/notification_model.dart';
import 'package:uniswap/models/product_model.dart';
import 'package:uniswap/theme/custom_button_style.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key, required this.notification});

  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    final amount = double.tryParse(notification.amount) ?? 0;
    final ProductController productController = Get.find<ProductController>();
    final ProductModel product = productController.products.firstWhere(
      (p) => p.docId == notification.metaProductId,
      orElse: () => ProductModel.empty(),
    );
    // if (product == null) {
    //   return const Center(child: Text("Product not found"));
    // }
    final code = notification.verificationCode ?? "";
    // final  MonnifyController controller = Get.find<MonnifyController>();
    final TextEditingController pinController = TextEditingController();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            notification.title,
            style: CustomTextStyles.text14wbold,
          ),
          centerTitle: true,
          actions: [
            Notifications(),
          ],
        ),
        drawer: Drawer(
          width: 271.w,
          child: DrawerWidget(),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            children: [
              if (notification.type == 'payment_verification') _buyerWidget(amount: amount, code: code, productname: product.productName ?? ""),

              // Seller confirm
              if (notification.type == 'payment_escrowed')
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 23.h),
                      decoration: TAppDecoration.outlineBlack9007.copyWith(
                        borderRadius: BorderRadiusStyle.customBorderTL20,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "You recieve payment of ",
                                  style: CustomTextStyles.text12w400,
                                ),
                                TextSpan(
                                  text: NumberFormat.currency(locale: 'en_NG', symbol: '₦').format(amount),
                                  style: CustomTextStyles.text12wBold,
                                ),
                                TextSpan(
                                  text: " for ${product.productName ?? " "} to ",
                                  style: CustomTextStyles.text12w400,
                                ),
                                TextSpan(
                                  text: "Escrow ",
                                  style: CustomTextStyles.text12wBold,
                                ),
                                TextSpan(
                                  text: "( Purchase being processed )",
                                  style: CustomTextStyles.text14w400cPrimary,
                                ),
                              ],
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: 11.h),
                          Text(
                            TFormatter.formatDateTime(DateTime.parse(notification.createdAt)),
                            style: CustomTextStyles.text14w400.copyWith(color: TColors.gray200),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                    CustomElevatedButton(
                      height: 24.h,
                      width: 85.w,
                      text: "Appeal",
                      margin: EdgeInsets.only(right: 3.w),
                      buttonStyle: CustomButtonStyles.fillTealA,
                      buttonTextStyle: CustomTextStyles.text14w400,
                      alignment: Alignment.centerRight,
                    ),
                    SizedBox(height: 14.h),
                    Container(
                      padding: EdgeInsets.all(14.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.w),
                        border: Border.all(
                          color: const Color(0xFF42D8B9),
                        ),
                        //color: appStore.whiteColor,
                      ),
                      child: Column(
                        children: [
                          // Text(
                          //   "(Purchase time confirmation countdown) ",
                          //   style: CustomTextStyles.text12w400,
                          // ),
                          // SizedBox(height: 14.h),
                          // Text(
                          //   "24hrs : 30mins : 17secs",
                          //   style: CustomTextStyles.text16Bold.copyWith(color: TColors.pink),
                          // ),
                          SizedBox(height: 17.h),
                          Container(
                            width: 289.w,
                            margin: EdgeInsets.only(left: 26.w, right: 25.w),
                            child: Text(
                              "Please enter verification code to confirm the delievery of the item for fund release",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.text12w400.copyWith(
                                height: 1.33,
                              ),
                            ),
                          ),
                          SizedBox(height: 19.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomOutlinedButton(
                                onPressed: () {
                                  showInputPinBottomSheet(
                                      context: context,
                                      // productname: "INPUT PIN",
                                      notification: notification,
                                      product: product);
                                },
                                width: 128.w,
                                height: 39.h,
                                text: "View Status",
                                buttonTextStyle: CustomTextStyles.text14w400.copyWith(color: TColors.primary),
                                // buttonStyle: ,
                              ),
                              CustomElevatedButton(
                                onPressed: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (BuildContext context) => SimpleDialog(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadiusStyle.roundedBorder10),
                                      alignment: Alignment.center,
                                      contentPadding: EdgeInsets.zero,
                                      backgroundColor: const Color(0xFFFFFFFF),
                                      children: [
                                        InputPinScreen(
                                          pincontroller: pinController,
                                          title: "INPUT VERIFICATION CODE",
                                          description: "Input your 6-digit verification code to continue",
                                          buttonText: "Comfirm Payment",
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "code field is required";
                                            } else if (value.length < 6 || value.length > 6) {
                                              return "max of 6 character is required";
                                            }
                                            return null;
                                          },
                                          onConfirm: () {},
                                        //   onConfirm: () => controller.confirmDelivery(
                                        //     transactionId: notification.transactionId,
                                        //     verificationCode: pinController.text.trim(),
                                        //     sellerId: notification.userId,
                                        //     productId: product.docId ?? '',
                                        //   ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                                height: 39.h,
                                width: 175.w,
                                text: "Purchase Confirmed",
                                buttonStyle: CustomButtonStyles.fillCyanTL7,
                                buttonTextStyle: CustomTextStyles.text14w400.copyWith(color: TColors.white),
                              ),
                            ],
                          ),
                          SizedBox(height: 5.h),
                        ],
                      ),
                    ),
                  ],
                ),

              // payment confirmed and released section
              if (notification.type == 'payment_released')
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 23.h),
                  decoration: TAppDecoration.outlineBlack9007.copyWith(
                    borderRadius: BorderRadiusStyle.customBorderTL20,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "You recieve escrow payment of ",
                              style: CustomTextStyles.text12w400,
                            ),
                            TextSpan(
                              text: NumberFormat.currency(locale: 'en_NG', symbol: '₦').format(amount),
                              style: CustomTextStyles.text12wBold,
                            ),
                            TextSpan(
                              text: " for ${product.productName ?? " "} to ",
                              style: CustomTextStyles.text12w400,
                            ),
                            TextSpan(
                              text: "main account ",
                              style: CustomTextStyles.text12wBold,
                            ),
                            TextSpan(
                              text: "( Purchase Completed )",
                              style: CustomTextStyles.text14w400cPrimary,
                            ),
                          ],
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 11.h),
                      Text(
                        TFormatter.formatDateTime(DateTime.parse(notification.createdAt)),
                        style: CustomTextStyles.text14w400.copyWith(color: TColors.gray200),
                      ),
                    ],
                  ),
                ),

              // payment confirmed and Success section
              if (notification.type == 'delivery_confirmed')
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 23.h),
                  decoration: TAppDecoration.outlineBlack9007.copyWith(
                    borderRadius: BorderRadiusStyle.customBorderTL20,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "All transaction ",
                              style: CustomTextStyles.text12w400,
                            ),
                            // TextSpan(
                            //   text: NumberFormat.currency(locale: 'en_NG', symbol: '₦').format(amount),
                            //   style: CustomTextStyles.text12wBold,
                            // ),
                            TextSpan(
                              text: " for ${product.productName ?? " "} ",
                              style: CustomTextStyles.text12w400,
                            ),
                            TextSpan(
                              text: "was completed successfully ",
                              style: CustomTextStyles.text12wBold,
                            ),
                            TextSpan(
                              text: "( Purchase Completed )",
                              style: CustomTextStyles.text14w400cPrimary,
                            ),
                          ],
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 11.h),
                      Text(
                        TFormatter.formatDateTime(DateTime.parse(notification.createdAt)),
                        style: CustomTextStyles.text14w400.copyWith(color: TColors.gray200),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void showInputPinBottomSheet(
      {required BuildContext context,
      // required String productname,
      required NotificationModel notification,
      required ProductModel product}) {
    final List? images = product.image;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 400.h, // control height here
          ),
          
          child: GFCard(
            boxFit: BoxFit.cover,
            titlePosition: GFPosition.end,
            image: Image.network(
              appwriteImageUrl(images?[0]),
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            showImage: true,
            title: GFListTile(
              // avatar: GFAvatar(
              //   backgroundImage: AssetImage('your asset image'),
              // ),
              titleText: product.productName ?? "",
              subTitleText: "₦${NumberFormat('#,##0', 'en_US').format(double.tryParse(product.startPrice ?? '0') ?? 0)}",
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text("Delivery Date"),
                    Text(notification.metaDeliveryDate, style: CustomTextStyles.text14w400cPrimary,),
                  ],
                ),
                SizedBox(height: 8.h),
                Column(
                  children: [
                    Text("Delivery Time"),
                    Text(notification.metaDeliveryTime, style: CustomTextStyles.text14w400cPrimary),
                  ],
                ),
              ],
            ),
            buttonBar: GFButtonBar(
              children: <Widget>[
                GFButton(
                  onPressed: () {Navigator.pop(context);},
                  text: 'Cancel',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buyerWidget({
    required double amount,
    required String code,
    required String productname,
  }) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 23.h),
          decoration: TAppDecoration.outlineBlack9007.copyWith(
            borderRadius: BorderRadiusStyle.customBorderTL20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "You sent payment of ",
                      style: CustomTextStyles.text12w400,
                    ),
                    TextSpan(
                      text: NumberFormat.currency(locale: 'en_NG', symbol: '₦').format(amount),
                      style: CustomTextStyles.text12wBold,
                    ),
                    TextSpan(
                      text: " for $productname to ",
                      style: CustomTextStyles.text12w400,
                    ),
                    TextSpan(
                      text: "Escrow ",
                      style: CustomTextStyles.text12wBold,
                    ),
                    TextSpan(
                      text: "( Purchase being processed )",
                      style: CustomTextStyles.text14w400cPrimary,
                    ),
                  ],
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 11.h),
              Text(
                TFormatter.formatDateTime(DateTime.parse(notification.createdAt)),
                style: CustomTextStyles.text14w400.copyWith(color: TColors.gray200),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 23.h),
          decoration: TAppDecoration.outlineBlack9007.copyWith(
            borderRadius: BorderRadiusStyle.customBorderTL20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 6,
                crossAxisAlignment: WrapCrossAlignment.center,
                runAlignment: WrapAlignment.center,
                children: [
                  Icon(
                    Icons.visibility_off,
                    size: 14.sp,
                  ),
                  Text(
                    "Swap code :",
                    style: CustomTextStyles.text12wBold,
                  ),
                  Text(
                    code,
                    style: CustomTextStyles.text12wBold.copyWith(color: TColors.primary),
                  ),
                ],
              ),
              SizedBox(height: 11.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: Icon(
                      Icons.access_time,
                      size: 14.sp,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(width: 7.h),
                  Expanded(
                    child: Text(
                      "Only give swap code to seller after receiving and confirming purchase, so escrow funds can be released to seller.",
                      style: CustomTextStyles.text12w400,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(height: 34.h),
        CustomElevatedButton(
          onPressed: () {
            Get.to(() => AppealScreen(
                  productId: notification.metaProductId,
                ));
          },
          height: 24.h,
          width: 85.w,
          text: "Appeal",
          margin: EdgeInsets.only(right: 3.w),
          buttonStyle: CustomButtonStyles.fillTealA,
          buttonTextStyle: CustomTextStyles.text14w400,
          alignment: Alignment.centerRight,
        ),
        SizedBox(height: 14.h),
        // Container(
        //   padding: EdgeInsets.all(14.w),
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(20.w),
        //     border: Border.all(
        //       color: const Color(0xFF42D8B9),
        //     ),
        //     //color: appStore.whiteColor,
        //   ),
        //   child: Column(
        //     children: [
        //       Text(
        //         "(Purchase time confirmation countdown) ",
        //         style: CustomTextStyles.text12w400,
        //       ),
        //       SizedBox(height: 14.h),
        //       Text(
        //         "24hrs : 30mins : 17secs",
        //         style: CustomTextStyles.text16Bold.copyWith(color: TColors.pink),
        //       ),
        //       SizedBox(height: 17.h),
        //       Container(
        //         width: 289.w,
        //         margin: EdgeInsets.only(left: 26.w, right: 25.w),
        //         child: Text(
        //           "Please confirm your purchase once you receive the item",
        //           maxLines: 2,
        //           overflow: TextOverflow.ellipsis,
        //           textAlign: TextAlign.center,
        //           style: CustomTextStyles.text12w400.copyWith(
        //             height: 1.33,
        //           ),
        //         ),
        //       ),
        //       SizedBox(height: 19.h),
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           CustomOutlinedButton(
        //             width: 128.w,
        //             height: 39.h,
        //             text: "View Status",
        //             buttonTextStyle: CustomTextStyles.text14w400.copyWith(color: TColors.primary),
        //             // buttonStyle: ,
        //           ),
        //           CustomElevatedButton(
        //             height: 39.h,
        //             width: 175.w,
        //             text: "Purchase Confirmed",
        //             buttonStyle: CustomButtonStyles.fillCyanTL7,
        //             buttonTextStyle: CustomTextStyles.text14w400.copyWith(color: TColors.white),
        //           ),
        //         ],
        //       ),
        //       SizedBox(height: 5.h),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}

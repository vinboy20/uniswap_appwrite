import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:uniswap/core/app_export.dart';

class EscrowTCScreen extends StatefulWidget {
  const EscrowTCScreen({super.key});

  @override
  State<EscrowTCScreen> createState() => _EscrowTCScreenState();
}

class _EscrowTCScreenState extends State<EscrowTCScreen> {
  bool ihavereadandiagreetothecontent = false;

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0XFF475569),
        body: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(24.w),

                  // decoration: TAppDecoration.fillBlueGray.copyWith(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Terms and Conditions - Escrow Service",
                        style: CustomTextStyles.text16b600cF1,
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        "These Terms and Conditions govern your use of the escrow service provided within the Uniswap app. By accessing or using the Service, you agree to comply with and be bound by this Agreement. If you do not agree with any part of the Agreement, please refrain from using the Service.",
                        maxLines: 6,
                        style: CustomTextStyles.text12w400cF1.copyWith(
                          height: 1.33,
                        ),
                      ),
                      SizedBox(height: 40.h),
                      SizedBox(
                        width: 310.w,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "\t1.\tEscrow Service\n",
                                style: CustomTextStyles.text14w400cF1,
                              ),
                              TextSpan(
                                text:
                                    "\n1.1 The Service facilitates secure transactions between buyers and sellers within the Uniswap app by acting as an impartial third-party intermediary.",
                                style: CustomTextStyles.text12w400cF1.copyWith(
                                  height: 1.80,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(height: 40.h),
                      SizedBox(
                        child: Text(
                          "1.2 The escrow process involves the following steps:\na. The buyer initiates a transaction and submits payment to the escrow account.\nb. The seller confirms the availability of the item or service and agrees to the terms of the transaction.\nc. The escrow service verifies the transaction details and holds the funds until the agreed conditions are met.\nd. Once the conditions are fulfilled, the funds are released to the seller.\ne. In case of disputes, the escrow service will conduct an investigation and make a fair and impartial decision.",
                          style: CustomTextStyles.text12w400cF1.copyWith(
                            height: 1.80,
                          ),
                        ),
                      ),
                      SizedBox(height: 40.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(left: 4.w, right: 15.w),
                          child: Text(
                            "1.3 The escrow service does not guarantee the quality, condition, or authenticity of the items or services being transacted. It is the responsibility of the buyer and seller to assess the suitability and reliability of the transaction.",
                            style: CustomTextStyles.text12w400cF1.copyWith(
                              height: 1.80,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildTopBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.h),
      color: Color(0XFFFFFFFF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            imagePath: TImages.logo,
            height: 37.h,
            width: 74.w,
            alignment: Alignment.center,
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                icon: Icon(Iconsax.arrow_left),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Welcome To Escrow Mode",
                    style: CustomTextStyles.titleMediumBlack900,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uniswap/common/widgets/button/custom_outlined_button.dart';
import 'package:uniswap/common/widgets/form/custom_text_form_field.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/controllers/product_controller.dart';
import 'package:uniswap/data/saved_data.dart';
import 'package:uniswap/models/bid_model.dart';
import 'package:uniswap/features/shop/screen/item_decription_screen/widgets/bid_amount.dart';
import 'package:uniswap/features/shop/screen/item_decription_screen/widgets/bid_time_widget.dart';


class BidWidget extends StatefulWidget {
  const BidWidget({
    super.key,
    required this.time,
    required this.date,
    required this.price,
    required this.productId, // Add productId to associate the bid with a product
  });

  final String? date;
  final String? time;
  final String? price;
  final String productId; // Product ID to associate the bid

  @override
  State<BidWidget> createState() => _BidWidgetState();
}

class _BidWidgetState extends State<BidWidget> {
  final controller = Get.put(ProductController());
  final TextEditingController _bidAmountController = TextEditingController();
  String? _selectedBidAmount; // Track the selected bid amount
  bool isCustomAmount = false; // Track if the user is entering a custom amount

  double? _highestBid; // Store the highest bid data
  int _numberOfBidders = 0; // Store the number of unique bidders

  @override
  void initState() {
    super.initState();
    _fetchBidData(); // Fetch the highest bid when the widget is initialized
  }

  @override
  void dispose() {
    _bidAmountController.dispose();
    super.dispose();
  }

  // Fetch the highest bid and number of bidders
  Future<void> _fetchBidData() async {
    
    // Fetch the highest bid
    final highestBid = await controller.getHighestBid(widget.productId);

    // Fetch the number of unique bidders
    final numberOfBidders = await controller.getNumberOfBidders(widget.productId);

    setState(() {
      _highestBid = highestBid;
      _numberOfBidders = numberOfBidders;
    });
  }

  Future<void> _submitBid(BuildContext context) async {
  // Get the bid amount
  final bidAmount = _selectedBidAmount ?? _bidAmountController.text;
  if (bidAmount.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Please enter a bid amount")),
    );
    return;
  }

  // Parse the bid amount (remove non-numeric characters)
  final parsedBidAmount = int.tryParse(bidAmount.replaceAll(RegExp(r'[^0-9]'), ''));
  if (parsedBidAmount == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Invalid bid amount. Please enter a valid number.")),
    );
    return;
  }


  // final bool isLoggedIn = box.read('isLoggedIn') ?? false;
      // String? userId = box.read('userId');
      String? userId = SavedData.getUserId();


  // Validate product ID
  if (widget.productId.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Invalid product. Please try again.")),
    );
    return;
  }

  // Create a BidModel
  final bid = BidModel(
    userId: userId, // Ensure userID is not null
    amount: parsedBidAmount, // Use the parsed bid amount
  );

  try {
    // Save the bid to the database
    await controller.saveOrUpdateBid(widget.productId, bid);

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Bid placed successfully!")),
    );

    // Refresh the bid data
    await _fetchBidData();

    // Close the dialog
    Navigator.of(context).pop();
  } catch (e) {
    // Show error message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Failed to place bid: ${e.toString()}")),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return CustomOutlinedButton(
      height: 55.h,
      text: "Place Bid  ",
      buttonStyle: TAppDecoration.softDark,
      buttonTextStyle: CustomTextStyles.text14w400cPrimary,
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => SimpleDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadiusStyle.roundedBorder22),
            alignment: Alignment.center,
            contentPadding: EdgeInsets.only(bottom: 30.h, left: 10.w, right: 10.w),
            backgroundColor: TColors.gray50,
            children: [
              Column(
                children: [
                  SizedBox(height: 28.h),
                  Text(
                    "Place Bid",
                    style: CustomTextStyles.text16Bold,
                  ),
                  SizedBox(height: 10.h),
                  const Divider(),
                  SizedBox(height: 17.h),
                  Column(
                    children: [
                      _buildNumberOfBid(
                        context,
                        numberOfBid: "Current bid Price:",
                        bidsCounter: _highestBid != null
                            ? "₦${NumberFormat('#,##0', 'en_US').format(_highestBid)}" // Directly format _highestBid
                            : "₦${NumberFormat('#,##0', 'en_US').format(int.tryParse(widget.price ?? '0') ?? 0)}",
                      ),
                      SizedBox(height: 14.h),
                      _buildNumberOfBid(
                        context,
                        numberOfBid: "Number of bidders:",
                        bidsCounter: "$_numberOfBidders bidders",
                      ),
                    ],
                  ),
                  SizedBox(height: 19.h),
                  TimeBal(
                    date: widget.date,
                    time: widget.time,
                  ),
                  SizedBox(height: 37.h),
                  Wrap(
                    runSpacing: 8,
                    spacing: 8,
                    children: [
                      BidAmount(
                        amount: "Bid 15,000",
                        selected: _selectedBidAmount == "15000",
                        onSelected: (isSelected) {
                          setState(() {
                            _selectedBidAmount = isSelected ? "15000" : null;
                            isCustomAmount = false;
                          });
                        },
                      ),
                      BidAmount(
                        amount: "Bid 35,000",
                        selected: _selectedBidAmount == "35000",
                        onSelected: (isSelected) {
                          setState(() {
                            _selectedBidAmount = isSelected ? "35000" : null;
                            isCustomAmount = false;
                          });
                        },
                      ),
                      BidAmount(
                        amount: "Bid 50,000",
                        selected: _selectedBidAmount == "50000",
                        onSelected: (isSelected) {
                          setState(() {
                            _selectedBidAmount = isSelected ? "50000" : null;
                            isCustomAmount = false;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 26.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: CustomTextFormField(
                      controller: _bidAmountController,
                      hintText: "Input Bid",
                      hintStyle: CustomTextStyles.text12w400,
                      textInputAction: TextInputAction.done,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                      borderDecoration: OutlineInputBorder(
                        borderSide: const BorderSide(color: TColors.white),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      filled: true,
                      fillColor: TColors.white,
                      onChange: (value) {
                        setState(() {
                          isCustomAmount = value.isNotEmpty;
                          _selectedBidAmount = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 26.h),
                  CustomOutlinedButton(
                    text: "Place Bid  ",
                    buttonStyle: TAppDecoration.softDark,
                    buttonTextStyle: CustomTextStyles.text14w400cPrimary,
                    onPressed: () => _submitBid(context),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  /// Common widget
  Widget _buildNumberOfBid(
    BuildContext context, {
    required String numberOfBid,
    required String bidsCounter,
  }) {
    return SizedBox(
      width: 211.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            numberOfBid,
            style: CustomTextStyles.text14w400,
          ),
          Text(
            bidsCounter,
            style: CustomTextStyles.text16Bold.copyWith(
              color: TColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

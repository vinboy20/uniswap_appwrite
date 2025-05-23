import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uniswap/common/widgets/appbar/appbar.dart';
import 'package:uniswap/common/widgets/button/custom_elevated_button.dart';
import 'package:uniswap/common/widgets/button/custom_outlined_button.dart';
import 'package:uniswap/common/widgets/form/custom_text_form_field.dart';
import 'package:uniswap/common/widgets/layouts/positioning_layout.dart';
import 'package:uniswap/common/widgets/liked.dart';
import 'package:uniswap/controllers/product_controller.dart';
import 'package:uniswap/controllers/ticket_controller.dart';
import 'package:uniswap/core/utils/credentials.dart';
import 'package:uniswap/models/event_model.dart';
import 'package:uniswap/theme/custom_button_style.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class BookTicketScreen extends StatefulWidget {
  const BookTicketScreen({super.key, required this.event});

  final EventModel event;

  @override
  State<BookTicketScreen> createState() => _BookTicketScreenState();
}

class _BookTicketScreenState extends State<BookTicketScreen> {
  final TicketController eventController = Get.put(TicketController());
  TextEditingController amountController = TextEditingController();
  final ProductController productController = Get.find<ProductController>();
  double amount = 0;
  int sliderIndex = 0;

  void shareContent() {
    String text = 'Check out this amazing product!';
    String link = 'https://example.com/product/123';
    String shareText = '$text\n$link';

    Share.share(shareText);
  }

  int ticketCount = 1;
  int amountToPay = 0;

  void increase() {
    setState(() {
      ticketCount++;
      amountToPay = ticketCount * int.parse(widget.event.price?.replaceAll(RegExp(r'[^0-9]'), '') ?? '0'); // Convert and calculate
    });
  }

  void decrease() {
    if (ticketCount > 1) {
      setState(() {
        ticketCount--;
        amountToPay = ticketCount * int.parse(widget.event.price?.replaceAll(RegExp(r'[^0-9]'), '') ?? '0'); // Convert and calculate
      });
    }
  }

  void _callSeller(String phoneNumber) async {
    final Uri url = Uri.parse("tel:$phoneNumber");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print("Could not launch call");
    }
  }

  Future<void> buyTicket() async {}

  // Function to parse and format the date and time
  String formatDateTime() {
    final String dateString = widget.event.date.toString(); // Example date from Appwrite
    final String timeString = widget.event.startTime.toString();
    // Step 1: Parse the date and time strings into a DateTime object
    final dateParts = dateString.split('/');
    final timeParts = timeString.split(' ');
    final time = timeParts[0].split(':');

    int day = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int year = int.parse(dateParts[2]);
    int hour = int.parse(time[0]);
    int minute = int.parse(time[1]);

    // Convert 12-hour format to 24-hour format
    if (timeParts[1] == 'PM' && hour != 12) {
      hour += 12;
    }
    if (timeParts[1] == 'AM' && hour == 12) {
      hour = 0;
    }

    final dateTime = DateTime(year, month, day, hour, minute);

    // Step 2: Format the DateTime object into the desired format
    // final formattedDate = DateFormat('MMMM d, h:mm a').format(dateTime);
    final formattedDate = DateFormat('EEEE, MMMM d, h:mm a').format(dateTime);

    return formattedDate; // Output: "July 20, 8:00 PM"
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: TAppBar(
          showBackArrow: true,
          leadingOnPressed: () {
            Navigator.pop(context);
          },
          actions: [
            IconButton(
              onPressed: () => shareContent(),
              icon: Icon(
                Icons.share,
                size: 20.sp,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Tickets Details", style: CustomTextStyles.text16Bold),
              SizedBox(height: 21.h),
              _buildTicketTumbnail(context),
              // Align(
              //   alignment: Alignment.center,
              //   child: SizedBox(
              //     height: 6.h,
              //     child: AnimatedSmoothIndicator(
              //       activeIndex: sliderIndex,
              //       count: 3,
              //       axisDirection: Axis.horizontal,
              //       effect: ScrollingDotsEffect(
              //         spacing: 4,
              //         activeDotColor: appTheme.teal500,
              //         dotColor: appTheme.teal500.withOpacity(0.4),
              //         dotHeight: 6.h,
              //         dotWidth: 6.w,
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(height: 17.h),
              Text(
                widget.event.name ?? "",
                style: CustomTextStyles.text18w600c19,
              ),
              SizedBox(height: 13.h),
              Text(
                "By ${widget.event.owner ?? ""}",
                style: CustomTextStyles.text14wboldc19,
              ),
              SizedBox(height: 4.h),
              _buildTime(context),
              SizedBox(height: 31.h),
              Divider(
                indent: 1.w,
              ),
              SizedBox(height: 16.h),
              Text(
                "About Event",
                style: CustomTextStyles.text14wboldc19,
              ),
              SizedBox(height: 12.h),
              ReadMoreText(
                widget.event.description ?? "",
                trimMode: TrimMode.Line,
                colorClickableText: TColors.primary,
                trimCollapsedText: 'more detail',
                trimExpandedText: 'Show less',
                style: CustomTextStyles.text12w400,
              ),
              SizedBox(height: 24.h),
              Column(
                children: [
                  _buildEventInfo(
                    context,
                    icon: "assets/images/view-boards.png",
                    eventType: "Ticket type:",
                    record: CustomOutlinedButton(
                      height: 32.h,
                      width: 88.w,
                      text: widget.event.ticketType ?? "",
                      buttonStyle: CustomButtonStyles.none,
                      decoration: CustomButtonStyles.gradientOrangeAFToLightBlueFDecoration,
                      buttonTextStyle: CustomTextStyles.text12w600c47,
                    ),
                  ),
                  _buildEventInfo(
                    context,
                    icon: "assets/images/database.png",
                    eventType: "Ticket price:",
                    record: Text("₦${NumberFormat('#,##0', 'en_US').format(int.tryParse(widget.event.price ?? '0') ?? 0)}",
                        style: CustomTextStyles.text12w600c47),
                  ),
                  _buildEventInfo(
                    context,
                    icon: "assets/images/collection.png",
                    eventType: "Event type:",
                    record: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(color: Color(0xFF99FAE6), borderRadius: BorderRadius.circular(22)),
                      child: Text(widget.event.eventType ?? '', style: CustomTextStyles.text12w600c47),
                    ),
                  ),
                  _buildEventInfo(
                    context,
                    icon: "assets/images/clock.png",
                    eventType: "Duration:",
                    record: Text(
                      "${widget.event.startTime} - ${widget.event.endTime}",
                      style: CustomTextStyles.text12w600c47,
                    ),
                  ),
                  _buildEventInfo(
                    context,
                    icon: "assets/images/location-marker.png",
                    eventType: "Location:",
                    record: Text(
                      widget.event.location ?? "",
                      style: CustomTextStyles.text12w600c47,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24.h),

              Row(
                children: [
                  Text(
                    "Quantity",
                    style: CustomTextStyles.text14wbold,
                  ),
                  Spacer(),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          decrease();
                        },
                        icon: Icon(
                          Icons.chevron_left,
                          size: 25.sp,
                          color: Color(0xFF475569),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Text(
                          ticketCount.toString(),
                          style: CustomTextStyles.text12wBold,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      IconButton(
                        onPressed: () {
                          increase();
                        },
                        icon: Icon(
                          Icons.chevron_right,
                          size: 25.sp,
                          color: Color(0xFF475569),
                        ),
                      ),
                    ],
                  )
                ],
              ),

              SizedBox(height: 16.h),
              CustomElevatedButton(
                onPressed: () {
                  _callSeller(widget.event.phone ?? "");
                },
                height: 42.h,
                text: "Call seller",
                leftIcon: Icon(
                  Icons.call,
                  size: 26.sp,
                  color: Color(0xFf3FA2F7),
                ),
                buttonStyle: CustomButtonStyles.outlineBlue,
                buttonTextStyle: CustomTextStyles.text14w600cBlue,
              ),
              SizedBox(height: 40.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // CustomIconButton(
                  //   height: 34.h,
                  //   width: 34.h,
                  //   padding: EdgeInsets.all(6.w),
                  //   decoration: IconButtonStyleHelper.fillBlueGrayTL17,
                  //   child: IconButton(
                  //     onPressed: () {

                  //     },
                  //     icon: Icon(Icons.favorite, color: Color(value),),
                  //   ),
                  // ),
                  Liked(itemId: widget.event.docId ?? ''),
                  _buildBuyTicket(context),
                ],
              ),
              SizedBox(height: 30.h),
              _buildAddToCalendar(context),
              // SizedBox(height: 35.h),
              // Text(
              //   "Other Events like this",
              //   style: CustomTextStyles.text16Bold,
              // ),
              SizedBox(height: 13.h),
              // Row(
              //   children: [
              //     CustomImageView(
              //       imagePath: TImages.chair,
              //       height: 85.h,
              //       width: 123.w,
              //       radius: BorderRadius.circular(
              //         10.w,
              //       ),
              //     ),
              //     Padding(
              //       padding: EdgeInsets.only(left: 14.w),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             "The ProductCon",
              //             style: CustomTextStyles.text14w400,
              //           ),
              //           SizedBox(height: 18.h),
              //           Text(
              //             "By Mx media",
              //             style: theme.textTheme.labelLarge,
              //           ),
              //           SizedBox(height: 17.h),
              //           Text(
              //             "July 20th, 8:00PM",
              //             style: theme.textTheme.bodySmall,
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildTicketTumbnail(BuildContext context) {
    final List? images = widget.event.image;
    return CarouselSlider.builder(
      options: CarouselOptions(
        height: 336.h,
        initialPage: 0,
        autoPlay: true,
        viewportFraction: 1.0,
        enableInfiniteScroll: false,
        scrollDirection: Axis.horizontal,
        onPageChanged: (
          index,
          reason,
        ) {
          sliderIndex = index;
        },
      ),
      itemCount: images?.length,
      itemBuilder: (context, index, realIndex) {
        return CustomImageView(
          imagePath:
              "https://cloud.appwrite.io/v1/storage/buckets/${Credentials.productBucketId}/files/${images?[0]}/view?project=${Credentials.projectID}&mode=admin",
          height: 336.h,
          width: 342.w,
          radius: BorderRadius.circular(
            13.h,
          ),
        );
      },
    );
  }

  /// Section Widget
  Widget _buildTime(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          formatDateTime(),
          style: CustomTextStyles.text12w400,
        ),
        Text(
          "${widget.event.quantity} tickets left",
          style: CustomTextStyles.text12w400cpink,
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildAddToCalendar(BuildContext context) {
    return CustomElevatedButton(
      height: 45.h,
      text: "Add to calendar",
      leftIcon: Container(
        margin: EdgeInsets.only(right: 8.w),
        child: Icon(
          Icons.calendar_month_outlined,
          size: 18.sp,
          color: Color(0xFF475569),
        ),
      ),
      buttonStyle: CustomButtonStyles.outlineOnErrorb22,
      buttonTextStyle: CustomTextStyles.text14w600c0F,
    );
  }

  Widget _buildBuyTicket(BuildContext context) {
    return Expanded(
      child: CustomElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => SimpleDialog(
              contentPadding: EdgeInsets.all(0),
              children: [
                Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 0,
                  margin: const EdgeInsets.all(0),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusStyle.roundedBorder10,
                  ),
                  child: PositioningLayout(
                    child: Container(
                      height: 402.h,
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              " Escrow Mode",
                              style: CustomTextStyles.text14wbold,
                            ),
                          ),
                          SizedBox(height: 30.h),
                          Obx(() {
                            final wallets = productController.wallet;
                            if (wallets.isEmpty) return Text("₦0", style: CustomTextStyles.text18w600cPrimary);
                            final String amount = wallets.first.balance ?? "0";
                           
                            return Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 1.h),
                                  child: Text(
                                    "Wallet Balance",
                                    style: CustomTextStyles.text14wbold,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 40.h),
                                  child: Text(
                                    NumberFormat.currency(locale: 'en_NG', symbol: '₦').format(amount),
                                    style: CustomTextStyles.text14wboldcPrimary,
                                  ),
                                ),
                              ],
                            );
                          }),
                          SizedBox(height: 30.h),
                          Row(
                            children: [
                              Text(
                                "Amount to be paid",
                                style: CustomTextStyles.text14wbold,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 14.h),
                                child: Text(
                                  NumberFormat.currency(locale: 'en_NG', symbol: '₦').format(amountToPay),
                                  style: CustomTextStyles.text14wboldcPrimary,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 27.h),
                          CustomTextFormField(
                            controller: amountController,
                            enabled: false,
                            hintText: NumberFormat.currency(locale: 'en_NG', symbol: '₦').format(amountToPay),
                            hintStyle: CustomTextStyles.text14w400,
                            textInputAction: TextInputAction.done,
                            maxLines: 1,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 15.h,
                            ),
                            borderDecoration: TextFormFieldStyleHelper.outlinecyan,
                            filled: true,
                            fillColor: theme.colorScheme.onPrimaryContainer.withOpacity(1),
                          ),
                          SizedBox(height: 27.h),
                          CustomElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => SimpleDialog(
                                  contentPadding: EdgeInsets.all(0),
                                  children: [
                                    _buildInputPin(context),
                                  ],
                                ),
                              );
                              
                            },
                            height: 39.h,
                            text: "Pay Seller ${NumberFormat.currency(locale: 'en_NG', symbol: '₦').format(amountToPay)}",
                            buttonStyle: CustomButtonStyles.fillPrimaryTL7,
                            buttonTextStyle: CustomTextStyles.text14wbold,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        height: 45.h,
        text: "Buy Ticket",
        margin: EdgeInsets.only(left: 16.w),
        buttonStyle: CustomButtonStyles.outlineBlack,
        buttonTextStyle: CustomTextStyles.text14w600c0F,
      ),
    );
  }

   Widget _buildInputPin(BuildContext context) {
    return Container(
      height: 317.h,
      // width: 342.h,
      // decoration: AppDecoration.fillGray.copyWith(
      //   borderRadius: BorderRadiusStyle.roundedBorder10,
      // ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: PositioningLayout(
          child:Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(left: 16.h, right: 16.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "INPUT PIN",
                      style: CustomTextStyles.text14wbold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Input your 4-digit pin to complete transaction",
                      style: CustomTextStyles.text12wBold,
                    ),
                  ),
                  SizedBox(height: 27.h),
                  CustomTextFormField(
                    //controller: amountController,
                    hintText: "7896",
                    textInputType: TextInputType.number,
                    hintStyle: CustomTextStyles.text12w400,
                    textInputAction: TextInputAction.done,
                    contentPadding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 8.h),
                  ),
                  SizedBox(height: 27.h),
                  CustomElevatedButton(
                    height: 39.h,
                    text: "Confirm Payment",
                    buttonStyle: CustomButtonStyles.fillPrimaryTL7,
                    buttonTextStyle: CustomTextStyles.text14wbold,
                  ),
                ],
              ),
            ),
          ),
      )
    );
  }


  /// Common widget
  Widget _buildEventInfo(
    BuildContext context, {
    required String icon,
    required String eventType,
    required Widget record,
  }) {
    return DottedBorder(
      strokeWidth: 1.w,
      dashPattern: [2, 2],
      child: Padding(
        padding: EdgeInsets.all(14.h),
        child: Row(
          children: [
            CustomImageView(
              color: Color(0xFF42D8B9),
              imagePath: icon,
              height: 16.h,
              width: 16.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Text(
                eventType,
                style: CustomTextStyles.text14w400.copyWith(
                  color: appTheme.gray900,
                ),
              ),
            ),
            Spacer(),
            record,
          ],
        ),
      ),
    );
  }
}

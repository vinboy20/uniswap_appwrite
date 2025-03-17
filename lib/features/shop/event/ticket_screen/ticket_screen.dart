import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uniswap/common/widgets/appbar/appbar.dart';
import 'package:uniswap/common/widgets/search/search_event_button_field.dart';
import 'package:uniswap/controllers/ticket_controller.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/core/utils/credentials.dart';
import 'package:uniswap/features/shop/event/book_ticket_screen/book_ticket_screen.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({super.key});

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  final TicketController eventController = Get.put(TicketController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const TAppBar(showBackArrow: true),
        body: Obx(() {
          final myEvent = eventController.events.where((event) => event.isApproved == true).toList();
          if (eventController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (myEvent.isEmpty) {
            return const Center(child: Text('No Event available.'));
          } else {
            return Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // searchbar
                  SearchEventButtonField(),
                  SizedBox(height: 24.h),
                  Text("Tickets", style: CustomTextStyles.text16Bold),
                  SizedBox(height: 24.h),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 242.h,
                        crossAxisCount: 2,
                        mainAxisSpacing: 22.h,
                        crossAxisSpacing: 22.h,
                      ),
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: myEvent.length,
                      itemBuilder: (context, index) {
                        final event = eventController.events[index];
                        final List? images = event.image;
                        final String dateString = event.date.toString(); // Example date from Appwrite
                        final String timeString = event.startTime.toString(); // Example time from Appwrite

                        // Function to parse and format the date and time
                        String formatDateTime() {
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
                          final formattedDate = DateFormat('MMMM d, h:mm a').format(dateTime);

                          return formattedDate; // Output: "July 20, 8:00 PM"
                        }

                        return GestureDetector(
                          onTap: () {
                            Get.to(() => BookTicketScreen(event: event));
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
                                        CustomImageView(
                                          width: 159.w,
                                          fit: BoxFit.cover,
                                          imagePath:
                                              "https://cloud.appwrite.io/v1/storage/buckets/${Credentials.productBucketId}/files/${images[0]}/view?project=${Credentials.projectID}&mode=admin",
                                        )
                                      else
                                        const Placeholder(
                                          fallbackHeight: 116,
                                          fallbackWidth: double.maxFinite,
                                          color: Colors.grey,
                                        ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        // This allows the Text widget to wrap within available space
                                        child: Text(
                                          event.name ?? "",
                                          maxLines: 2,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          style: CustomTextStyles.text14w600c0F,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Padding(
                                  padding: EdgeInsets.only(left: 6.w),
                                  child: Text(
                                    "₦${NumberFormat('#,##0', 'en_US').format(int.tryParse(event.price ?? '0') ?? 0)}",
                                    style: CustomTextStyles.text12wBold,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                                  child: Text(
                                    formatDateTime(),
                                    style: CustomTextStyles.text12w400,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        event.location ?? "Unknown",
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

                  SizedBox(height: 19.h),
                ],
              ),
            );
          }
        }),
      
      ),
    );
  }
}

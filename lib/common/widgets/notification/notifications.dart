import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniswap/controllers/notification_controller.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/features/personalization/screen/notification/notification_list_screen.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    final NotificationController controller = Get.put(NotificationController());
    return GestureDetector(
      onTap: () {
        Get.to(() => const NotificationListScreen());
      },
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 24.w),
            child: Stack(
              children: [
                Container(
                  width: 36.h,
                  height: 36.h,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF1F5F9),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 1, color: Color(0xFFE2E8F0)),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Icon(
                    Icons.notifications,
                    size: 23.sp,
                    color: const Color(0xFF42D8B9),
                  ),
                ),
                Positioned(
                  left: 20.w,
                  top: 4,
                  child: Obx(() {
                    final unreadCount = controller.unreadCount.value;
                    // Only show badge if there are unread notifications
                    if (unreadCount == 0) return SizedBox.shrink();

                    return Container(
                      alignment: Alignment.center,
                      width: 14.w,
                      height: 14.w,
                      decoration: TAppDecoration.boxWhite.copyWith(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        unreadCount > 9 ? "9+" : unreadCount.toString(),
                        style: CustomTextStyles.text12w400cpink,
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

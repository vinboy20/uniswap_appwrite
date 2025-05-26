import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniswap/controllers/notification_controller.dart';
import 'package:uniswap/features/personalization/screen/notification/notification_screen.dart';

class NotificationListScreen extends StatelessWidget {
  const NotificationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
  final NotificationController controller = Get.find<NotificationController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        actions: [
          IconButton(
            icon: const Icon(Icons.mark_email_read),
            onPressed: controller.markAllAsRead,
            tooltip: 'Mark all as read',
          ),
        ],
      ),
      body: Obx(() {
        if (controller.notifications.isEmpty) {
          return Center(child: Text("No notifications"));
        }
        
        return 
        ListView.builder(
          itemCount: controller.notifications.length,
          itemBuilder: (context, index) {
            final notification = controller.notifications[index];
            return ListTile(
              title: Text(notification.title),
              subtitle: Text(controller.formatNotificationDate(notification.createdAt)),
              trailing: notification.isRead ? null : Icon(Icons.circle, size: 8, color: Colors.green),
              onTap: () {
                controller.markAsRead(notification.id);
                Get.to(() => NotificationScreen(notification: notification));
              },
            );
          },
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniswap/controllers/notification_controller.dart';
import 'package:uniswap/features/personalization/screen/notification/notification_screen.dart';

class NotificationListScreen extends StatelessWidget {
  const NotificationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
  final NotificationController _controller = Get.put(NotificationController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        actions: [
          IconButton(
            icon: const Icon(Icons.mark_email_read),
            onPressed: _controller.markAllAsRead,
            tooltip: 'Mark all as read',
          ),
        ],
      ),
      body: Obx(() {
        if (_controller.notifications.isEmpty) {
          return Center(child: Text("No notifications"));
        }
        
        return 
        ListView.builder(
          itemCount: _controller.notifications.length,
          itemBuilder: (context, index) {
            final notification = _controller.notifications[index];
            return ListTile(
              title: Text(notification.title),
              subtitle: Text(_controller.formatNotificationDate(notification.createdAt)),
              trailing: notification.isRead ? null : Icon(Icons.circle, size: 8, color: Colors.green),
              onTap: () {
                _controller.markAsRead(notification.id);
                Get.to(() => NotificationScreen(notification: notification));
              },
            );
          },
        );
      }),
    );
  }
}

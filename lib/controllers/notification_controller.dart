import 'dart:math';
import 'package:appwrite/appwrite.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uniswap/core/utils/credentials.dart';
import 'package:uniswap/data/saved_data.dart';
import 'package:uniswap/models/notification_model.dart';

class NotificationController extends GetxController {
  static NotificationController get instance => Get.find();

  final Account _account = Account(Get.find<Client>());
  final Databases _databases = Databases(Get.find<Client>());

  final String databaseId = Credentials.databaseId;
  final String userCollectionId = Credentials.usersCollectonId;
  final String notificationCollectionId = Credentials.notificationCollectionId;

  // Reactive list of notifications
  final RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  final RxInt unreadCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  // Get current user ID
  Future<String?> getCurrentUserId() async {
    try {
      final user = await _account.get();
      return user.$id;
    } catch (e) {
      Get.log('Error getting current user: $e', isError: true);
      return null;
    }
  }

  // Fetch all notifications for current user
  Future<void> fetchNotifications() async {
    try {
      // EasyLoading.show(status: 'Loading notifications...');
      final userId = SavedData.getUserId();

      if (userId == null) {
        EasyLoading.showError('User not logged in');
        return;
      }

      final response = await _databases.listDocuments(
        databaseId: databaseId,
        collectionId: notificationCollectionId,
        queries: [
          Query.equal('userId', userId),
          Query.orderDesc('\$createdAt'),
          Query.limit(100),
        ],
      );

      notifications.assignAll(response.documents.map((doc) => NotificationModel.fromJson(doc.data)).toList());
      unreadCount.value = notifications.where((n) => !n.isRead).length;
    } on AppwriteException catch (e) {
      print('Appwrite Error: ${e.message}');
      EasyLoading.showError('Failed to load notifications: ${e.message}');
    } catch (e) {
      print('Unexpected Error: $e');
      EasyLoading.showError('Failed to load notifications');
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> markAsRead(String notificationId) async {
    try {
      // Find the notification index
      final index = notifications.indexWhere((n) => n.id == notificationId);
      if (index == -1) return;

      // Only proceed if notification is unread
      if (!notifications[index].isRead) {
        // Update local state first
        notifications[index] = notifications[index].copyWith(isRead: true);
        unreadCount.value = unreadCount.value - 1; // Decrement only once

        // Update server
        await _databases.updateDocument(
          databaseId: databaseId,
          collectionId: notificationCollectionId,
          documentId: notificationId,
          data: {'isRead': true},
        );
      }
    } catch (e) {
      Get.log('Error marking notification as read: $e', isError: true);
      // Revert local changes if server update fails
      final index = notifications.indexWhere((n) => n.id == notificationId);
      if (index != -1 && notifications[index].isRead) {
        notifications[index] = notifications[index].copyWith(isRead: false);
        unreadCount.value = unreadCount.value + 1;
      }
    }
  }

  // Mark all notifications as read
  Future<void> markAllAsRead() async {
    try {
      EasyLoading.show(status: 'Marking all as read...');
      final unreadIds = notifications.where((n) => !n.isRead).map((n) => n.id).toList();

      // Update locally first
      for (var i = 0; i < notifications.length; i++) {
        if (!notifications[i].isRead) {
          notifications[i] = notifications[i].copyWith(isRead: true);
        }
      }
      unreadCount.value = 0;

      // Update on server in batches if needed
      for (final id in unreadIds) {
        await _databases.updateDocument(
          databaseId: databaseId,
          collectionId: notificationCollectionId,
          documentId: id,
          data: {'isRead': true},
        );
      }
    } catch (e) {
      Get.log('Error marking all notifications as read: $e', isError: true);
      EasyLoading.showError('Failed to mark all as read');
    } finally {
      EasyLoading.dismiss();
    }
  }

  // Format date for display
  String formatNotificationDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('MMM dd, hh:mm a').format(date);
    } catch (e) {
      return dateString;
    }
  }

  // Get notification by ID
  NotificationModel? getNotificationById(String id) {
    try {
      return notifications.firstWhere((n) => n.id == id);
    } catch (e) {
      return null;
    }
  }

  // Create a test notification (for development)
  Future<void> createTestNotification() async {
    try {
      final userId = await getCurrentUserId();
      if (userId == null) return;

      final types = ['payment_verification', 'payment_escrowed', 'system_alert'];
      final random = Random();

      await _databases.createDocument(
        databaseId: databaseId,
        collectionId: notificationCollectionId,
        documentId: ID.unique(),
        data: {
          'userId': userId,
          'type': types[random.nextInt(types.length)],
          'title': 'Test Notification',
          'message': 'This is a test notification',
          'amount': (random.nextInt(10000) + 1000).toString(),
          'code': (random.nextInt(900000) + 100000).toString(),
          'isRead': false,
          'createdAt': DateTime.now().toIso8601String(),
          'metaDeliveryDate': '2023-12-15',
          'metaDeliveryTime': '14:00',
        },
      );

      await fetchNotifications();
    } catch (e) {
      Get.log('Error creating test notification: $e', isError: true);
    }
  }
}

import 'package:get/get.dart';
import 'package:appwrite/appwrite.dart';
import 'package:uniswap/core/utils/credentials.dart';

class ChatController extends GetxController {
  final Databases databases = Databases(Get.find<Client>());
  final Realtime realtime = Realtime(Get.find<Client>());

  final RxList<Map<String, dynamic>> messages = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> chats = <Map<String, dynamic>>[].obs;
  final RxMap<String, bool> onlineStatus = <String, bool>{}.obs; // Store online status

  final String databaseId = Credentials.databaseId;
  final String chatCollectionId = Credentials.chatCollectionId;
  final String activeCollectionId = Credentials.activeCollectionId;

  RealtimeSubscription? _realtimeSubscription; // Store the subscription
  RealtimeSubscription? _presenceSubscription;

  @override
  void onInit() {
    super.onInit();
    _subscribeToRealtime();
    _subscribeToPresence();
  }

  @override
  void onClose() {
    _unsubscribeFromRealtime(); // Dispose of the subscription
    _unsubscribeFromPresence();
    super.onClose();
  }

  // Send a message
  Future<void> sendMessage(String senderId, String receiverId, String message) async {
    try {
      await databases.createDocument(
        databaseId: databaseId,
        collectionId: chatCollectionId,
        documentId: ID.unique(),
        data: {
          'senderId': senderId,
          'receiverId': receiverId,
          'message': message,
          'timestamp': DateTime.now().toIso8601String(),
        },
      );
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  // Fetch messages between two users
  Future<void> fetchMessages(String senderId, String receiverId) async {
    try {
      final response = await databases.listDocuments(
        databaseId: databaseId,
        collectionId: chatCollectionId,
        queries: [
          Query.or([
            Query.and([
              Query.equal('senderId', [senderId]),
              Query.equal('receiverId', [receiverId]),
            ]),
            Query.and([
              Query.equal('senderId', [receiverId]),
              Query.equal('receiverId', [senderId]),
            ]),
          ]),
        ],
      );

      // Sort messages by timestamp
      final sortedMessages = response.documents.map((doc) => doc.data).toList();
      sortedMessages.sort((a, b) {
        final aTimestamp = DateTime.parse(a['timestamp']);
        final bTimestamp = DateTime.parse(b['timestamp']);
        return aTimestamp.compareTo(bTimestamp); // Sort in ascending order
      });

      messages.assignAll(sortedMessages);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  // Fetch all chats for a user
  Future<void> fetchChats(String userId) async {
    try {
      final response = await databases.listDocuments(
        databaseId: databaseId,
        collectionId: chatCollectionId,
        queries: [
          // Query.or([
          //   Query.equal('senderId', [userId]),
          //   Query.equal('receiverId', [userId]),
          // ]),
          Query.or(
            [
              Query.equal("senderId", userId),
              Query.equal("receiverId", userId),
            ],
          ),
        ],
      );

      // Group chats by the other user's ID
      final Map<String, Map<String, dynamic>> groupedChats = {};

      for (final doc in response.documents) {
        final chat = doc.data;
        final isMe = chat['senderId'] == userId;
        final otherUserId = isMe ? chat['receiverId'] : chat['senderId'];

        // If the other user is already in the map, check if this message is newer
        if (groupedChats.containsKey(otherUserId)) {
          final existingChat = groupedChats[otherUserId]!;
          final existingTimestamp = DateTime.parse(existingChat['timestamp']);
          final newTimestamp = DateTime.parse(chat['timestamp']);

          // Replace the existing chat if this message is newer
          if (newTimestamp.isAfter(existingTimestamp)) {
            groupedChats[otherUserId] = chat;
          }
        } else {
          // Add the chat to the map
          groupedChats[otherUserId] = chat;
        }
      }

      // Convert the map to a list and assign it to the chats observable
      chats.assignAll(groupedChats.values.toList());
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  // Subscribe to real-time updates
  void _subscribeToRealtime() {
    _realtimeSubscription = realtime.subscribe(['databases.$databaseId.collections.$chatCollectionId.documents']);

    _realtimeSubscription?.stream.listen((event) {
      if (event.events.contains('databases.*.collections.*.documents.*.create')) {
        final newMessage = event.payload;
        // Add the new message to the messages list
        messages.add(newMessage);
      }
    });
  }

  // Subscribe to real-time updates for presence
  void _subscribeToPresence() {
    _presenceSubscription = realtime.subscribe(['databases.$databaseId.collections.$activeCollectionId.documents']);

    _presenceSubscription?.stream.listen((event) {
      if (event.events.contains('databases.*.collections.*.documents.*.update')) {
        final presenceUpdate = event.payload;
        final userId = presenceUpdate['userId'];
        final isOnline = presenceUpdate['isOnline'];
        onlineStatus[userId] = isOnline;
      }
    });
  }

  Future<bool> fetchOnlineStatus(String userId) async {
    try {
      final response = await databases.getDocument(
        databaseId: databaseId,
        collectionId: activeCollectionId,
        documentId: userId,
      );
      return response.data['isOnline'] ?? false;
    } catch (e) {
      if (e is AppwriteException && e.code == 404) {
        // If the document doesn't exist, the user is offline
        return false;
      } else {
        print('Error fetching online status: $e');
        Get.snackbar("Error", e.toString());
        return false;
      }
    }
  }

  Future<void> updateUserStatus(String userId, bool isOnline) async {
    try {
      // Check if the document already exists
      try {
        await databases.getDocument(
          databaseId: databaseId,
          collectionId: activeCollectionId,
          documentId: userId,
        );

        // If the document exists, update it
        await databases.updateDocument(
          databaseId: databaseId,
          collectionId: activeCollectionId,
          documentId: userId,
          data: {
            'isOnline': isOnline,
            'lastSeen': DateTime.now().toIso8601String(),
          },
        );
      } catch (e) {
        // If the document doesn't exist, create it
        if (e is AppwriteException && e.code == 404) {
          await databases.createDocument(
            databaseId: databaseId,
            collectionId: activeCollectionId,
            documentId: userId,
            data: {
              'userId': userId,
              'isOnline': isOnline,
              'lastSeen': DateTime.now().toIso8601String(),
            },
          );
        } else {
          rethrow; // Re-throw other errors
        }
      }
    } catch (e) {
      print('Error updating user status: $e');
      Get.snackbar("Error", e.toString());
    }
  }

  // Mark user as online
  Future<void> markUserOnline(String userId) async {
    await updateUserStatus(userId, true);
  }

// Mark user as offline
  Future<void> markUserOffline(String userId) async {
    await updateUserStatus(userId, false);
  }

  // Unsubscribe from real-time updates
  void _unsubscribeFromRealtime() {
    _realtimeSubscription?.close(); // Close the subscription
  }

  // Unsubscribe from real-time updates for presence
  void _unsubscribeFromPresence() {
    _presenceSubscription?.close();
  }
}

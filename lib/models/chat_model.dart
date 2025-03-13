// class ChatModel {
//   final String id;
//   final String message;
//   final String senderId;
//   final String receiverId;
//   final String timestamp;

//   ChatModel({
//     required this.id,
//     required this.message,
//     required this.senderId,
//     required this.receiverId,
//     required this.timestamp,
//   });

//   /// Convert Appwrite document data to Message object
//   factory ChatModel.fromMap(Map<String, dynamic> map) {
//     return ChatModel(
//       id: map['\$id'] ?? '', // Appwrite assigns a unique document ID
//       message: map['message'] ?? '',
//       senderId: map['senderId'] ?? '',
//       receiverId: map['receiverId'] ?? '',
//       timestamp: map['timestamp'] ?? '',
//     );
//   }

//   /// Convert Message object to JSON for storing in Appwrite
//   Map<String, dynamic> toMap() {
//     return {
//       'message': message,
//       'senderId': senderId,
//       'receiverId': receiverId,
//       'timestamp': timestamp,
//     };
//   }
// }

import 'package:uniswap/models/message_model.dart';
import 'package:uniswap/models/user.dart';

class ChatDataModel {
  final MessageModel message;
  final List<UserModel> users;

  ChatDataModel({required this.message, required this.users});
}

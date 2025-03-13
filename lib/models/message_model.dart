class MessageModel {
  final String message;
  final String sender;
  final String receiver;
  final String? messageId;
  final DateTime timestamp;
  final bool isSeenByReceiver;

  MessageModel({
    required this.message,
    required this.sender,
    required this.receiver,
    this.messageId,
    required this.timestamp,
    required this.isSeenByReceiver,
  });

  // that will convert Document model to message model
  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
        message: map["message"],
        sender: map["senderId"],
        receiver: map["receiverId"],
        timestamp: DateTime.parse(map["timestamp"]),
        isSeenByReceiver: map["isSeenbyReceiver"],
        messageId: map["\$id"]);
  }
}

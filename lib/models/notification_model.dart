class NotificationModel {
  final String id;
  final String userId;
  final String transactionId;
  final String type;
  final String title;
  final String amount;
  final String? verificationCode;
  final bool isRead;
  final String metaProductId;
  final String metaDeliveryDate;
  final String metaDeliveryTime;
  final String createdAt;

  NotificationModel({
    required this.id,
    required this.userId,
    required this.transactionId,
    required this.type,
    required this.title,
    required this.amount,
    this.verificationCode,
    required this.isRead,
    required this.metaProductId,
    required this.metaDeliveryDate,
    required this.metaDeliveryTime,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['\$id'] ?? '',
      userId: json['userId'] ?? '',
      transactionId: json['transactionId'] ?? '',
      type: json['type'] ?? '',
      title: json['title'] ?? '',
      amount: json['amount'] ?? '',
      verificationCode: json['verificationCode'] ?? '',
      isRead: json['isRead'],
      metaProductId: json['metaProductId'] ?? '',
      metaDeliveryDate: json['metaDeliveryDate'] ?? '',
      metaDeliveryTime: json['metaDeliveryTime'] ?? '',
      // createdAt: DateTime.parse(json['\$createdAt']),
       createdAt: json['\$createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'transactionId': transactionId,
      'type': type,
      'title': title,
      'amount': amount,
      'verificationCode': verificationCode,
      'isRead': isRead,
      'metaProductId': metaProductId,
      'metaDeliveryDate': metaDeliveryDate,
      'metaDeliveryTime': metaDeliveryTime,
    };
  }

  NotificationModel copyWith({
    String? id,
    String? userId,
    String? transactionId,
    String? type,
    String? title,
    String? amount,
    String? verificationCode,
    bool? isRead,
    String? metaProductId,
    String? metaDeliveryDate,
    String? metaDeliveryTime,
    DateTime? createdAt,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      transactionId: transactionId ?? this.transactionId,
      type: type ?? this.type,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      verificationCode: verificationCode ?? this.verificationCode,
      isRead: isRead ?? this.isRead,
      metaProductId: metaProductId ?? this.metaProductId,
      metaDeliveryDate: metaDeliveryDate ?? this.metaDeliveryDate,
      metaDeliveryTime: metaDeliveryTime ?? this.metaDeliveryTime,
      createdAt: createdAt != null ? createdAt.toIso8601String() : this.createdAt,
    );
  }
}

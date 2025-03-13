class TransactionModel {
  String? docId;
  String? userId;
  int? amount;
  String? type;
  String? txRef;
  String? transactionId;
  String? transactionStatus;
  String? createdAt;

  TransactionModel({
    this.docId,
    required this.userId,
    required this.amount,
    this.type,
    this.txRef,
    this.transactionId,
    this.transactionStatus,
    this.createdAt,
  });

  TransactionModel.fromJson(Map<String, dynamic> json) {
    docId = json['\$id'];
    userId = json['userId'];
    amount = json['amount'] is int ? json['amount'] : int.tryParse(json['amount'].toString()); // Convert to int
    type = json['type'];
    txRef = json['txRef'];
    transactionId = json['transactionId'];
    transactionStatus = json['transactionStatus'];
    createdAt = json['\$createdAt'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userId'] = userId;
    data['amount'] = amount;
    data['type'] = type;
    data['txRef'] = txRef;
    data['transactionId'] = transactionId;
    data['transactionStatus'] = transactionStatus;
    return data;
  }
}
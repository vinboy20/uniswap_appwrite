class TransactionModel {
  String? docId;
  String? userId;
  String? buyerId;
  String? sellerId;
  String? status;
  String? amount;
  String? type;
  String? txRef;
  bool? sellerConfirm = false;
  // String? transactionId;
  String? transactionStatus;
  String? createdAt;

  TransactionModel({
    this.docId,
    required this.userId,
    this.buyerId,
    this.sellerId,
    required this.amount,
    this.type,
    this.status,
    this.txRef,
    this.sellerConfirm,
    // this.transactionId,
    // this.transactionStatus,
    this.createdAt,
  });

  TransactionModel.fromJson(Map<String, dynamic> json) {
    docId = json['\$id'];
    userId = json['userId'];
    buyerId = json['buyerId'];
    sellerId = json['sellerId'];
    amount = json['amount'];
    // amount = json['amount'] is double ? json['amount'] : double.tryParse(json['amount'].toString()); // Convert to int
    type = json['type'];
    status = json['status'];
    txRef = json['txRef'];
    sellerConfirm = json['sellerConfirm'];
    // transactionId = json['transactionId'];
    // transactionStatus = json['transactionStatus'];
    createdAt = json['\$createdAt'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userId'] = userId;
    data['buyerId'] = buyerId;
    data['sellerId'] = sellerId;
    data['amount'] = amount;
    data['type'] = type;
    data['status'] = status;
    data['sellerConfirm'] = sellerConfirm;
    data['txRef'] = txRef;
    // data['transactionId'] = transactionId;
    // data['transactionStatus'] = transactionStatus;
    return data;
  }
}

// class TransactionModel {
//   String? id;
//   String? buyerId;
//   String? sellerId;
//   String? amount;
//   String? type;
//   String? userId;
//   String? status;
//   String? txRef;
//   String? transactionId;
//   String? transactionStatus;
//   final String? createdAt;

//   TransactionModel({
//     this.id,
//     this.buyerId,
//     required this.userId,
//     this.sellerId,
//     this.amount,
//     this.type,
//      this.txRef,
//     this.transactionId,
//     this.transactionStatus,
//     this.status,
//     this.createdAt,
//   });

//   factory TransactionModel.fromJson(Map<String, dynamic> json) {
//     return TransactionModel(
//       id: json['\$id'],
//       userId: json['userId'],
//       buyerId: json['buyerId'],
//       sellerId: json['sellerId'],
//       amount: json['amount'],
//       type: json['type'],
//       txRef: json['txRef'],
//     transactionId: json['transactionId'],
//     transactionStatus: json['transactionStatus'],
//       status: json['status'],
//       createdAt: json['date'] ?? json['createdAt'],
//     );
//   }
// }

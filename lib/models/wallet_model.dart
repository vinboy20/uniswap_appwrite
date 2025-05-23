// class WalletModel {
//   String? docId;
//   String? userId;
//   String? balance;
//   // String? productId; // Add this field
//   // ProductModel? product; // Add this field to store product details

//   WalletModel({
//     this.docId,
//     required this.userId,
//     required this.balance,
//     // this.productId,
//   });

//  WalletModel.fromJson(Map<String, dynamic> json) {
//   docId = json['\$id'];
//   userId = json['userId'];
//   // balance = json['balance'] != null ? (int.tryParse(json['balance'].toString()) ?? 0).toDouble() : null;
//   balance = json['balance'];
// }


//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['userId'] = userId;
//     data['balance'] = balance;
//     // data['productId'] = productId; // Add this field
//     return data;
//   }
// }

class WalletModel {
  final String docId; // Make this non-nullable
  final String userId;
  final String balance;
  final String escrowBalance;

  WalletModel({
    required this.docId, // Now required
    required this.userId,
    required this.balance,
    required this.escrowBalance,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      docId: json['\$id'] ?? json['userId'], // Fallback to userId if $id missing
      userId: json['userId'],
      balance: json['balance']?.toString() ?? '0.00', // Ensure string
      escrowBalance: json['escrowBalance']?.toString() ?? '0.00', // Ensure string
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'balance': balance,
      'escrowBalance': escrowBalance,
      // 'createdAt': DateTime.now().toIso8601String(),
    };
  }
}

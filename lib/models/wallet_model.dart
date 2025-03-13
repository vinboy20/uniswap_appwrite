class WalletModel {
  String? docId;
  String? userId;
  int? balance;
  // String? productId; // Add this field
  // ProductModel? product; // Add this field to store product details

  WalletModel({
    this.docId,
    required this.userId,
    required this.balance,
    // this.productId,
  });

 WalletModel.fromJson(Map<String, dynamic> json) {
  docId = json['\$id'];
  userId = json['userId'];
  balance = json['balance'] != null ? int.tryParse(json['balance'].toString()) ?? 0 : 0;
}


  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userId'] = userId;
    data['balance'] = balance;
    // data['productId'] = productId; // Add this field
    return data;
  }
}
class BidModel {
  String? docId;
  String? userId;
  int? amount;
  String? productId; // Add this field
  // ProductModel? product; // Add this field to store product details

  BidModel({
    this.docId,
    required this.userId,
    required this.amount,
    this.productId,
    // this.product, // Initialize product
  });

  BidModel.fromJson(Map<String, dynamic> json) {
    docId = json['\$id'];
    userId = json['userId'];
    amount = json['amount'] is int ? json['amount'] : int.tryParse(json['amount'].toString()); // Convert to int
    productId = json['productId'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userId'] = userId;
    data['amount'] = amount;
    data['productId'] = productId; // Add this field
    return data;
  }
}
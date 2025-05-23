class WithdrawModel {
  final String docId; // Make this non-nullable
  final String userId;
  final String amount;
  final String status;
  String? createdAt;

  WithdrawModel({
    required this.docId, // Now required
    required this.userId,
    required this.amount,
    required this.status,
    this.createdAt
  });

  factory WithdrawModel.fromJson(Map<String, dynamic> json) {
    return WithdrawModel(
      docId: json['\$id'] ?? json['userId'], // Fallback to userId if $id missing
      userId: json['userId'] ?? '',
      amount: json['amount']?.toString() ?? '0.00', // Ensure string
      status: json['status'] ?? "",
      createdAt: json['\$createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'amount': amount,
      'status': status,
    };
  }
}

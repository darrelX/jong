class TransactionModel {
  final int? id;
  final int? amount;
  final int? status;
  final int? userId;
  final String? mehod;

  TransactionModel(
      {required this.amount,
      required this.id,
      required this.status,
      required this.userId,
      required this.mehod});

  factory TransactionModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return TransactionModel(
        id: int.parse(json['id'].toString()) as int?,
        amount: int.parse(json['amount'].toString()) as int?,
        status: int.parse(json['status'].toString()) as int?,
        userId: int.parse(json['user_id'].toString()) as int?,
        mehod: json['method'].toString() as String?);
  }

  // factory TransactionModel.copyWith(Map<String, dynamic> json) {
  //   return TransactionModel(amount: amount, status: null, userId: null, mehod: '');
  // }
}

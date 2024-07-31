class GameHistoryModel {
  final int? id;
  final int? userId;
  final int? gameId;
  final double? amount;
  final double? cote;
  final double? gain;
  final DateTime? createdAt;

  GameHistoryModel({
    required this.id,
    required this.userId,
    required this.gameId,
    required this.amount,
    required this.cote,
    required this.gain,
    required this.createdAt,
  });

  factory GameHistoryModel.fromJson(Map<String, dynamic> json) {
    return GameHistoryModel(
        id: json['id'] as int?,
        userId: json['user_id'] as int?,
        gameId: json['game_id'] as int?,
        amount: double.parse(json['amount'].toString()) as double?,
        cote: double.parse(json['cote'].toString()) as double?,
        gain: double.parse(json['gain'].toString()) as double?,
        createdAt: DateTime.parse(json['created_at'].toString()) as DateTime?);
  }
}

class GameHistoryModel {
  final int? id;
  final int? userId;
  final int? gameId;
  final double? amount;
  final double? cote;
  final double? gain;
  final int? total;
  final DateTime? createdAt;

  GameHistoryModel({
    required this.id,
    required this.userId,
    required this.gameId,
    required this.amount,
    required this.cote,
    required this.gain,
    this.total,
    required this.createdAt,
  });

  factory GameHistoryModel.fromJson(Map<String, dynamic> json) {
    return GameHistoryModel(
        id: json['id'] as int?,
        userId: json['user_id'] as int?,
        gameId: json['game_id'] as int?,
        amount: double.parse(json['amount'].toString()) as double?,
        total: json.length as int?,
        cote: double.parse(json['cote'].toString()) as double?,
        gain: double.parse(json['gain'].toString()) as double?,
        createdAt: DateTime.parse(json['created_at'].toString()) as DateTime?);
  }

  GameHistoryModel copyWith({
    int? id,
    int? userId,
    int? gameId,
    double? amount,
    double? cote,
    double? gain,
    int? total,
    DateTime? createdAt,
  }) {
    return GameHistoryModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      gameId: gameId ?? this.gameId,
      amount: amount ?? this.amount,
      cote: cote ?? this.cote,
      gain: gain ?? this.gain,
      total: total ?? this.total,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

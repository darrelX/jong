class GameModel {
  final int? userId;
  final int? gameId;
  final double? amount;
  final double? cote;
  final double? gain;

  const GameModel(
      {required this.userId,
      required this.gameId,
      required this.amount,
      required this.cote,
      required this.gain});

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
        userId: int.parse(json['user_id'].toString()) as int?,
        gameId: int.parse(json['game_id'].toString()) as int?,
        amount: int.parse(json['amount'].toString()) as double?,
        cote: double.parse(json['cote'].toString()) as double?,
        gain: double.parse(json['gain'].toString()) as double?);
  }

  toJson() {
    return <String,dynamic> {
      'user_id' : userId,
      'game_id' : gameId,
      'amount' : amount,
      'cote' : cote,
      'gain' : gain
    };
  }
}

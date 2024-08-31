part of 'crash_game_bloc.dart';

sealed class CrashGameState extends Equatable {
  final double bet;

  const CrashGameState({required this.bet});

  @override
  List<Object> get props => [bet];
}

final class CrashGameDefault extends CrashGameState {
  const CrashGameDefault({
    required super.bet,
  });

  @override
  List<Object> get props => [bet];
}

final class CrashGameInitial extends CrashGameState {
  final int countDown;
  const CrashGameInitial({
    required super.bet,
    required this.countDown,
  });

  @override
  List<Object> get props => [bet, countDown];
}

final class CrashGamePlaying extends CrashGameState {
  final double multiplier;

  const CrashGamePlaying({
    required super.bet,
    required this.multiplier,
  });

  @override
  List<Object> get props => [bet, multiplier];
}

final class CrashGameWon extends CrashGameState {
  final double multiplier;

  double get winnings => super.bet * multiplier;

  const CrashGameWon({
    required super.bet,
    required this.multiplier,
  });

  @override
  List<Object> get props => [bet, multiplier];
}

final class CrashGameLost extends CrashGameState {
  final double multiplier;

  const CrashGameLost({
    required super.bet,
    required this.multiplier,
  });

  @override
  List<Object> get props => [bet, multiplier];
}

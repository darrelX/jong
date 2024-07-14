part of 'crash_game_bloc.dart';

sealed class CrashGameEvent extends Equatable {
  const CrashGameEvent();

  @override
  List<Object> get props => [];
}

final class InitializeCrashGameEvent extends CrashGameEvent {}

final class StartCrashGameEvent extends CrashGameEvent {}

final class CrashGamePayingProcessEvent extends CrashGameEvent {
  final double multiplier;

  const CrashGamePayingProcessEvent({required this.multiplier});

  @override
  List<Object> get props => [multiplier];
}

final class GameCrashEvent extends CrashGameEvent {
  final double multiplier;

  const GameCrashEvent({required this.multiplier});

  @override
  List<Object> get props => [multiplier];
}

final class CashOutCrashGameWinningsEvent extends CrashGameEvent {
  final double multiplier;

  const CashOutCrashGameWinningsEvent({required this.multiplier});

  @override
  List<Object> get props => [multiplier];
}


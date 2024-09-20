part of 'game_history_cubit.dart';

sealed class GameHistoryState extends Equatable {
  const GameHistoryState();

  @override
  List<Object> get props => [];
}

final class GameHistoryStateInitial extends GameHistoryState {
  const GameHistoryStateInitial();

  @override
  List<Object> get props => [];
}

final class GameHistoryStateLoading extends GameHistoryState {
  const GameHistoryStateLoading();

  @override
  List<Object> get props => [];
}

final class GameHistoryStateSuccess extends GameHistoryState {
  final List<GameHistoryModel> listGameHistory;
  const GameHistoryStateSuccess({required this.listGameHistory});

  @override
  List<Object> get props => [listGameHistory];
}

final class GameHistoryStateFailure extends GameHistoryState {
  final String message;
  const GameHistoryStateFailure({required this.message});

  @override
  List<Object> get props => [message];
}

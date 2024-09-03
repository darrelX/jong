import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jong/history/data/models/game_history_model.dart';
import 'package:jong/history/data/repositories/game_history_repository.dart';
import 'package:jong/service_locator.dart';
import 'package:jong/shared/application/cubit/application_cubit.dart';
// import 'package:jong/history/data/repositories/ticket_repository.dart';

part 'game_history_state.dart';

class GameHistoryCubit extends Cubit<GameHistoryState> {
  final GameHistoryRepository repository;
  final ApplicationCubit applicationCubit;

  List<GameHistoryModel> _listGameHistory = [];
  GameHistoryCubit()
      : repository = GameHistoryRepository(),
        applicationCubit = getIt.get<ApplicationCubit>(),
        super(const GameHistoryStateInitial());

  fetch() async {
    _listGameHistory.clear();
    emit(const GameHistoryStateLoading());
    try {
      _listGameHistory = (await repository.fetchGameHistory(
        userId: applicationCubit.state.user!.id!,
      ))!;
      emit(GameHistoryStateSuccess(listGameHistory: _listGameHistory));
    } catch (e) {
      emit(GameHistoryStateFailure(message: e.toString()));
      rethrow;
    }
  }

  refreshList({required int page}) async {
    emit(const GameHistoryStateLoading());
    try {
      final copy = (await repository.fetchGameHistory(
          userId: applicationCubit.state.user!.id!, page: page))!;
      _listGameHistory.addAll(copy);
      emit(GameHistoryStateSuccess(listGameHistory: _listGameHistory));
    } catch (e) {
      emit(GameHistoryStateFailure(message: e.toString()));
      rethrow;
    }
  }
}
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

  /// A flag indicating whether the maximum number of movies has been reached.
  bool hasReachedMax = false;

  /// The current page number for fetching popular movies.
  int _page = 1;

  final List<GameHistoryModel> _listGameHistory = [];
  GameHistoryCubit()
      : repository = GameHistoryRepository(),
        applicationCubit = getIt.get<ApplicationCubit>(),
        super(const GameHistoryStateInitial());

  fetch() async {
    if (state is! GameHistoryStateSuccess) {
      emit(const GameHistoryStateLoading());
    }
    try {
      // Checks if the maximum limit has been reached.
      if (hasReachedMax) return;
      final result = (await repository.fetchGameHistory(
          userId: applicationCubit.state.user!.id!, page: _page));
      _page++;

      _listGameHistory.addAll(result.list
          .where((movie) => _listGameHistory.contains(movie) == false)
          .toList());
      emit(GameHistoryStateSuccess(listGameHistory: _listGameHistory.toList()));

      if (_page == result.total) {
        hasReachedMax = true;
      }
    } catch (e) {
      emit(GameHistoryStateFailure(message: e.toString()));
      rethrow;
    }
  }

  refreshList({required int page}) async {
    emit(const GameHistoryStateLoading());
    try {
      final copy = (await repository.fetchGameHistory(
          userId: applicationCubit.state.user!.id!, page: page));
      _listGameHistory.addAll(copy.list);
      emit(GameHistoryStateSuccess(listGameHistory: _listGameHistory));
    } catch (e) {
      emit(GameHistoryStateFailure(message: e.toString()));
      rethrow;
    }
  }
}

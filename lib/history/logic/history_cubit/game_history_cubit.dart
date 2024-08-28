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
  GameHistoryCubit()
      : repository = GameHistoryRepository(),
        applicationCubit = getIt.get<ApplicationCubit>(),
        super(const GameHistoryStateInitial());

  fetch({int page=1}) async {
    emit(const GameHistoryStateLoading());

    try {
      List<GameHistoryModel> listGameHistory = (await repository
          .fetchGameHistory(userId: applicationCubit.state.user!.id!, page: page))!;

      emit(GameHistoryStateSuccess(listGameHistory: listGameHistory));
    } catch (e) {
      emit( GameHistoryStateFailure(message: e.toString()));
      rethrow;
    }
  }
}

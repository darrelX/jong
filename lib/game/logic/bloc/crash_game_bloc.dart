import 'dart:async';
import 'dart:math';
import 'dart:developer' as dev;

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jong/game/data/repositories/game_repository.dart';
import 'package:jong/game/extensions/game_extensions.dart';
import 'package:jong/service_locator.dart';
import 'package:jong/shared/application/cubit/application_cubit.dart';

part 'crash_game_event.dart';
part 'crash_game_state.dart';

class CrashGameBloc extends Bloc<CrashGameEvent, CrashGameState> {
  final double bet;
  Timer? timer;
  double crashPoint = 0.0;
  final GameRepository _repository = GameRepository();
  final ApplicationCubit applicationCubit = getIt.get<ApplicationCubit>();

  CrashGameBloc({
     this.bet = 0,
  }) : super(CrashGameDefault(bet: bet)) {
    on<InitializeCrashGameEvent>(_onInitialize);
    on<StartCrashGameEvent>(_onStartGame);
    on<CrashGamePayingProcessEvent>(_onPayingProcess);
    on<GameCrashEvent>(_onGameCrash);
    on<CashOutCrashGameWinningsEvent>(_onCashOut);
  }

  Future<void> _onInitialize(
      InitializeCrashGameEvent event, Emitter<CrashGameState> emit) async {
    int countDown = 3;
    emit(CrashGameInitial(bet: bet, countDown: countDown));

    for (var i = countDown; i > 0; i--) {
      await Future.delayed(const Duration(seconds: 1));
      emit(CrashGameInitial(bet: bet, countDown: i));
    }

    add(StartCrashGameEvent());
  }

  void _onStartGame(StartCrashGameEvent event, Emitter<CrashGameState> emit) {
    crashPoint = crashPoint.generateCrashNumber();
    double multiplier = 0.0;

    timer = Timer.periodic(const Duration(milliseconds: 100), (_) async {
      dev.log("multiplier = $multiplier : crashPoint = $crashPoint");

      if (multiplier >= crashPoint) {
        dev.log("Game Crash ");
        _.cancel();
        add(GameCrashEvent(multiplier: multiplier));
      } else {
        multiplier += 0.05;
        dev.log("New Multiplier: $multiplier || crashPoint = $crashPoint");
        add(CrashGamePayingProcessEvent(multiplier: multiplier));
      }
    });
  }

  void _onPayingProcess(
      CrashGamePayingProcessEvent event, Emitter<CrashGameState> emit) {
    emit(CrashGamePlaying(bet: bet, multiplier: event.multiplier));
  }

  void _onGameCrash(GameCrashEvent event, Emitter<CrashGameState> emit) {
    _repository.gameResult({
      'user_id': applicationCubit.state.user!.id,
      'game_id': 1,
      'amount': bet,
      "cote": event.multiplier,
      "gain": -bet
    });
    emit(CrashGameLost(bet: bet, multiplier: event.multiplier));
  }

  void _onCashOut(
      CashOutCrashGameWinningsEvent event, Emitter<CrashGameState> emit) {
    timer?.cancel();
    _repository.gameResult({
      'user_id': applicationCubit.state.user!.id,
      'game_id': 1,
      'amount': bet,
      "cote": event.multiplier,
      "gain": bet * event.multiplier
    });
    emit(CrashGameWon(bet: bet, multiplier: event.multiplier));
  }

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }
}

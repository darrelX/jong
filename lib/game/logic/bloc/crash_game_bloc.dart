import 'dart:async';
import 'dart:math';
import 'dart:developer' as dev;

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'crash_game_event.dart';
part 'crash_game_state.dart';

class CrashGameBloc extends Bloc<CrashGameEvent, CrashGameState> {
  final double bet;

  Timer? timer;

  CrashGameBloc({
    required this.bet,
  }) : super(
          CrashGameDefault(bet: bet),
        ) {
    on<InitializeCrashGameEvent>(
      (event, emit) async {
        int countDown = 5;
        emit(
          CrashGameInitial(
            bet: bet,
            countDown: countDown,
          ),
        );

        for (var i = countDown; i >= 0; i--) {
          await Future.delayed(const Duration(seconds: 1));
          emit(
            CrashGameInitial(
              bet: bet,
              countDown: i,
            ),
          );
        }

        add(StartCrashGameEvent());
      },
    );

    on<StartCrashGameEvent>(
      (event, emit) {
        var crashPoint = Random().nextDouble() * 10;
        // var crash
        var multiplier = 0.0;

        timer = Timer.periodic(
          const Duration(milliseconds: 100),
          (_) async {
            // dev.log("multiplier = $multiplier : crashPoint = $crashPoint");

            if (multiplier >= crashPoint) {
              dev.log("Game Crash ");
              _.cancel();
              add(GameCrashEvent(multiplier: multiplier));
            } else {
              multiplier = multiplier + 0.05;
              dev.log(
                "New Multiplier: $multiplier || crashPoint = $crashPoint",
              );
              add(
                CrashGamePayingProcessEvent(
                  multiplier: multiplier,
                ),
              );
            }
          },
        );
      },
    );

    on<CrashGamePayingProcessEvent>((event, emit) {
      emit(
        CrashGamePlaying(
          bet: bet,
          multiplier: event.multiplier,
        ),
      );
    });

    on<GameCrashEvent>(
      (event, emit) {
        emit(
          CrashGameLost(
            bet: bet,
            multiplier: event.multiplier,
          ),
        );
      },
    );

    on<CashOutCrashGameWinningsEvent>((event, emit) {
      timer?.cancel();
      emit(
        CrashGameWon(
          bet: bet,
          multiplier: event.multiplier,
        ),
      );
    });
  }

  dispose() {
    timer?.cancel();
  }
}

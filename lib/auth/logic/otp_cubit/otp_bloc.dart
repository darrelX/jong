import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jong/auth/data/repositories/otp_repository.dart';
import 'package:jong/shared/utils/utils.dart';

part 'otp_state.dart';
part 'otp_event.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  Timer? _timer;
  static const int totalDuration = 120;
  final OtpRepository _repository;
  int _currentDuration = totalDuration;

  OtpBloc()
      : _repository = OtpRepository(),
        super(const OtpInitial(countDown: totalDuration)) {
    on<OtpSubmitted>(_onSubmit);
    on<OtpReset>(_onReset);
    on<OtpInitialized>(_onInitialized);
    on<_OtpTick>(_onTick); // Utilisation d'un event spécifique au timer
  }

  Future<void> _onSubmit(OtpSubmitted event, Emitter<OtpState> emit) async {
    if (state is OtpSentInProgress) {
      emit(OtpVerifying(countDown: state.countDown));
    }
    try {
      final status = await _repository.submit(
        code: event.otp,
        phoneNumber: event.phoneNumber,
      );
      if (status) {
        _timer?.cancel();
        emit(const OtpVerificationSuccess(countDown: totalDuration));
      } else {
        emit(const OtpVerificationFailure(
            errorMessage: 'Echec', countDown: totalDuration));
      }
    } catch (e) {
      emit(OtpVerificationFailure(
          errorMessage: Utils.extractErrorMessage(e),
          countDown: totalDuration));
    }
  }

  Future<void> _onInitialized(
      OtpInitialized event, Emitter<OtpState> emit) async {
    _timer?.cancel();
    emit(const OtpLoadingState(countDown: totalDuration));
    try {
      await _repository.sendOtp(event.phoneNumber);
      _startTimer(emit);
      // emit(OtpSentInProgress(countDown: _currentDuration));
    } catch (e) {
      emit(OtpSendFailure(
          errorMessage: Utils.extractErrorMessage(e),
          countDown: totalDuration));
    }
  }

  void _startTimer(Emitter<OtpState> emit) {
    _currentDuration = totalDuration;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _currentDuration--;
      add(_OtpTick(countDown: _currentDuration));
      // }
    });
  }

  Future<void> _onTick(_OtpTick event, Emitter<OtpState> emit) async {
    emit(event.countDown > 0
        ? OtpSentInProgress(countDown: event.countDown)
        : const OtpExpired());
    if (event.countDown <= 0) {
      _timer?.cancel();
    }
  }

  Future<void> _onReset(OtpReset event, Emitter<OtpState> emit) async {
    _timer?.cancel();

    if (state is OtpExpired || state is OtpVerificationFailure) {
      emit(const OtpVerifying(countDown: 0));
      try {
        await _repository.sendOtp(event.phoneNumber);
        _startTimer(emit);
        emit(OtpSentInProgress(countDown: _currentDuration));
      } catch (e) {
        emit(OtpSendFailure(
            errorMessage: Utils.extractErrorMessage(e),
            countDown: totalDuration));
      }
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}

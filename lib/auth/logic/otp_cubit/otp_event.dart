part of 'otp_bloc.dart';

sealed class OtpEvent extends Equatable {
  const OtpEvent();

  @override
  List<Object> get props => [];
}

class OtpSubmitted extends OtpEvent {
  final String otp;
  final String phoneNumber;

  const OtpSubmitted({required this.otp, required this.phoneNumber});

  @override
  List<Object> get props => [otp];
}

class OtpReset extends OtpEvent {
  final String phoneNumber;

  const OtpReset({required this.phoneNumber});
  @override
  List<Object> get props => [];
}

class _OtpTick extends OtpEvent {
  final int countDown;
  const _OtpTick({required this.countDown});

  @override
  List<Object> get props => [countDown];
}

class OtpInitialized extends OtpEvent {
  final String phoneNumber;
  final int duration;
  const OtpInitialized({required this.phoneNumber, required this.duration});

  @override
  List<Object> get props => [phoneNumber];
}

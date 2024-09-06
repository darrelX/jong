part of 'otp_bloc.dart';

sealed class OtpState extends Equatable {
  final int countDown;
  const OtpState({required this.countDown});

  @override
  List<Object> get props => [countDown];
}

// L'état initial où l'OTP est en attente d'envoi.
final class OtpInitial extends OtpState {
  const OtpInitial({required super.countDown});

  @override
  List<Object> get props => [super.countDown];
}

// État lorsque l'OTP est envoyé et le processus est en cours (page en chargement).
final class OtpSentInProgress extends OtpState {
  const OtpSentInProgress({required super.countDown});

  @override
  List<Object> get props => [super.countDown];
}

// État lorsque le code OTP a été validé avec succès.
final class OtpVerificationSuccess extends OtpState {
  const OtpVerificationSuccess({required super.countDown});

  @override
  List<Object> get props => [super.countDown];
}

// État lorsque l'utilisateur entre un code OTP incorrect.
final class OtpVerificationFailure extends OtpState {
  final String errorMessage;
  const OtpVerificationFailure(
      {required this.errorMessage, required super.countDown});

  @override
  List<Object> get props => [errorMessage, super.countDown];
}

// État lorsque l'envoi du code OTP a echoue.
final class OtpSendFailure extends OtpState {
  final String errorMessage;
  const OtpSendFailure({required this.errorMessage, required super.countDown});

  @override
  List<Object> get props => [errorMessage, super.countDown];
}

// État lorsque le code OTP est en train d'être validé.
final class OtpVerifying extends OtpState {
  const OtpVerifying({required super.countDown});

  @override
  List<Object> get props => [super.countDown];
}

// État lorsque la page est en train de charger avant l'envoi de l'OTP.
final class OtpLoadingState extends OtpState {
  const OtpLoadingState({required super.countDown});

  @override
  List<Object> get props => [super.countDown];
}

// L'etat ou le compte a rebours a expire.
final class OtpExpired extends OtpState {
  const OtpExpired() : super(countDown: 0);

  @override
  List<Object> get props => [super.countDown];

}

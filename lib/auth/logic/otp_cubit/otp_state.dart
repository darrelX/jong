part of 'otp_cubit.dart';

sealed class OtpState extends Equatable {
  const OtpState();

  @override
  List<Object> get props => [];
} 

final class OtpInitial extends OtpState {
  const OtpInitial();

  
  @override
  List<Object> get props => [];
}

final class OtpSuccess extends OtpState {
  final String code;
  const OtpSuccess({required this.code});

  
  @override
  List<Object> get props => [code];
}

final class OtpFailure extends OtpState {
  final String message;
  const OtpFailure({required this.message});

  
  @override
  List<Object> get props => [message];
}

// final class OtpSuccess extends OtpState {
//   const OtpSuccess();
// }

part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

final class LoginLoading extends AuthState {}

final class LoginFailure extends AuthState {
  final String message;
  const LoginFailure({required this.message});
  @override
  List<Object> get props => [message];
}

final class LoginSuccess extends AuthState {
  final UserModel user;
  const LoginSuccess({required this.user});
  @override
  List<Object> get props => [user];
}

final class RegisterLoading extends AuthState {}

final class RegisterFailure extends AuthState {
  final String message;
  const RegisterFailure({required this.message});
  @override
  List<Object> get props => [message];
}

final class RegisterSuccess extends AuthState {
  final UserModel user;
  const RegisterSuccess({required this.user});
  @override
  List<Object> get props => [user];
}

final class CheckAuthStateLoading extends AuthState {}

final class CheckAuthStateFailure extends AuthState {
  final String message;
  const CheckAuthStateFailure({required this.message});
  @override
  List<Object> get props => [message];
}

final class CheckAuthStateSuccess extends AuthState {
  final UserModel user;
  const CheckAuthStateSuccess({required this.user});
  @override
  List<Object> get props => [user];
}

import 'package:equatable/equatable.dart';
import 'package:jong/auth/data/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jong/auth/data/repositories/auth_repository.dart';
import 'package:jong/service_locator.dart';
import 'package:jong/shared/utils/utils.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repository = getIt.get<AuthRepository>();
  AuthCubit() : super(AuthInitial());

  login({
    required String email,
    required String password,
  }) async {
    try {
      emit(LoginLoading());
      var user = await repository.login(
        email: email,
        password: password,
      );
      emit(LoginSuccess(user: user!));
    } catch (e) {
      emit(LoginFailure(message: Utils.extractErrorMessage(e)));
    }
  }

  register({
    required String username,
    required String email,
    required DateTime birthDate,
    required int gender,
    required String phone,
    required String password,
  }) async {
    try {
      emit(RegisterLoading());
      var user = await repository.register(
        username: username,
        email: email,
        birthDate: birthDate,
        gender: gender,
        phone: phone,
        password: password,
      );
      emit(RegisterSuccess(user: user!));
    } catch (e) {
      print(e);
      emit(RegisterFailure(message: Utils.extractErrorMessage(e)));
    }
  }

  checkAuthState() async {
    try {
      emit(CheckAuthStateLoading());
      var user = await repository.getUser();
      emit(CheckAuthStateSuccess(user: user!));
    } catch (e) {
      emit(CheckAuthStateFailure(message: Utils.extractErrorMessage(e)));
    }
  }
}

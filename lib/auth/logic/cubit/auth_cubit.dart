import 'package:equatable/equatable.dart';
import 'package:jong/auth/data/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jong/auth/data/repositories/auth_repository.dart';
import 'package:jong/service_locator.dart';
import 'package:jong/shared/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repository = getIt.get<AuthRepository>();
  final prefs = getIt.get<Future<SharedPreferences>>();

  AuthCubit() : super(AuthInitial());

  login({
    required String phone,
    required String password,
  }) async {
    try {
      emit(LoginLoading());
      var user = await repository.login(
        phone: phone,
        password: password,
      );
      emit(LoginSuccess(user: user!));
    } catch (e) {
      emit(LoginFailure(message: Utils.extractErrorMessage(e)));
    }
  }

  register({
    required String name,
    required String email,
    required DateTime birthDate,
    required int gender,
    required String phoneNumber,
    required String password,
  }) async {
    try {
      emit(RegisterLoading());
      var user = await repository.register(
        username: name,
        email: email,
        birthDate: birthDate,
        gender: gender,
        phone: phoneNumber,
        password: password,
      );
      emit(RegisterSuccess(user: user!));
    } catch (e) {
      print(e);
      emit(RegisterFailure(message: Utils.extractErrorMessage(e)));
    }
  }

  Future<void> checkAuthState() async {
    final storage = await prefs;
    final token = storage.getString('token');
    try {
      emit(CheckAuthStateLoading());

      if (token != null || token!.isEmpty) {
        var user = await repository.getUser(token);
        emit(CheckAuthStateSuccess(user: user!));
      } else {
        emit(CheckAuthStateFailure(
            message: Utils.extractErrorMessage('User is not authenticated')));
      }
    } catch (e) {
      emit(CheckAuthStateFailure(message: Utils.extractErrorMessage(e)));
    }
  }
}

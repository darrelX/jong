import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jong/auth/data/models/user_model.dart';
import 'package:jong/service_locator.dart';
import 'package:jong/shared/application/repositories/application_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'application_state.dart';

class ApplicationCubit extends Cubit<ApplicationState> {
  final _repository = ApplicationRepository();
  final pref = getIt.get<Future<SharedPreferences>>();
  ApplicationCubit() : super(const ApplicationStateInitial());

  setUser([UserModel? userModel]) async {
    if (userModel != null) {
      emit(ApplicationStateInitial(user: userModel));
    }
    final prefs = await pref;
    final user = await _repository.getUser(prefs.getString('token')!);
    emit(ApplicationStateInitial(user: user));
  }

  dynamic deposit(
      String method, int amount, int userId, String phoneNumber) async {
    try {
      final Map<String, dynamic> response = await _repository.deposit(
          method: method,
          amount: amount,
          userId: userId,
          phoneNumber: phoneNumber);
      print("test");
      setUser();
      if (response['status'] == 0) {
        emit(const ApplicationStatePending());
      }

      // return status['status'];
    } catch (e) {
      emit(const ApplicationStateFailure());
    }
  }

  logout() async {
    final SharedPreferences prefs =
        await getIt.get<Future<SharedPreferences>>();
    prefs.remove('token');
  }
}

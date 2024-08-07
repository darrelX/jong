import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jong/auth/data/models/user_model.dart';
import 'package:jong/service_locator.dart';
import 'package:jong/shared/application/repositories/application_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'application_state.dart';

class ApplicationCubit extends Cubit<ApplicationState> {
  final repository = ApplicationRepository();
  final pref = getIt.get<Future<SharedPreferences>>();
  ApplicationCubit() : super(const ApplicationState());

  setUser([UserModel? userModel]) async {
    if (userModel != null) {
      emit(ApplicationState(user: userModel));
    }
    final prefs = await pref;
    final user = await repository.getUser(prefs.getString('token')!);
    emit(ApplicationState(user: user));
  }

  deposit(String method, int amount, int userId) async {
    await repository.deposit(method: method, amount: amount, userId: userId);
    setUser();

    // emit(ApplicationState(user: ));
  }

  logout() async {
    final SharedPreferences prefs =
        await getIt.get<Future<SharedPreferences>>();
    prefs.remove('token');
  }
}

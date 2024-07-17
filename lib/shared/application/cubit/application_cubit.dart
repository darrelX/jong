import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jong/auth/data/models/user_model.dart';
import 'package:jong/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'application_state.dart';

class ApplicationCubit extends Cubit<ApplicationState> {
  ApplicationCubit() : super(const ApplicationState());

  setUser(UserModel? user) {
    emit(ApplicationState(user: user));
  }

  logout() async {
    final SharedPreferences prefs = await getIt.get<Future<SharedPreferences>>();
    prefs.remove('token');
  }
}

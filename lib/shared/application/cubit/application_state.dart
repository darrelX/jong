part of 'application_cubit.dart';

class ApplicationState extends Equatable {
  final UserModel? user;
  const ApplicationState({this.user});

  @override
  List<Object?> get props => [user];

  ApplicationState copyWith({
    UserModel? user,
  }) {
    return ApplicationState(
      user: user ?? this.user,
    );
  }
}

part of 'network_cubit.dart';

sealed class NetworkState extends Equatable {
  final Status status;
  const NetworkState({required this.status});

  @override
  List<Object?> get props => [status];
}

class NetworkInitial extends NetworkState {
  const NetworkInitial({required super.status});

  @override
  List<Object?> get props => [super.status];
}

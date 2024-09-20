import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';
import 'package:equatable/equatable.dart';
part 'network_state.dart';

enum Status { connected, disconnected }

class NetworkCubit extends Cubit<NetworkState> {
  // final Connectivity _connectivity;
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  late Status status;

  NetworkCubit() : super(const NetworkInitial(status: Status.connected)) {
    // Écouter les changements de connectivité
    _initialize();
  }

  void _initialize() {
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen(
      (List<ConnectivityResult> result) {
        _updateConnectionStatus(result);
      },
    );
  }

  // Mise à jour de l'état de connexion
  void _updateConnectionStatus(List<ConnectivityResult> result) {
    if (result.contains(ConnectivityResult.none)) {
      emit(const NetworkInitial(status: Status.disconnected));
    } else {
      emit(const NetworkInitial(status: Status.connected));
    }
  }

  // Annuler l'abonnement à la connectivité lors de la fermeture du Cubit
  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}

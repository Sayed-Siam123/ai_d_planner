import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

import '../../constants/enum_constants.dart';
import '../../utils/helper/print_log.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  StreamSubscription? connectivityStreamSubscription;

  InternetCubit({required this.connectivity}) : super(InternetState.initial()) {
    monitorInternetConnection();
  }

  StreamSubscription<List<ConnectivityResult>> monitorInternetConnection() {
    return connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {

          printLog(connectivityResult);

      if (connectivityResult.contains(ConnectivityResult.wifi)) {
        emitInternetConnected(ConnectionType.Wifi);
      } else if (connectivityResult.contains(ConnectivityResult.mobile)) {
        emitInternetConnected(ConnectionType.Mobile);
      } else if (connectivityResult.contains(ConnectivityResult.none)) {
        emitInternetDisconnected();
      }
    });
  }

  void emitInternetConnected(ConnectionType connectionType) =>
      emit(state.copyWith(
          connectionType: connectionType,
          status: InternetStatusState.connected));

  void emitInternetDisconnected() => emit(state.copyWith(
      connectionType: ConnectionType.None,
      status: InternetStatusState.disconnected));

  @override
  Future<void> close() {
    connectivityStreamSubscription?.cancel();
    return super.close();
  }
}

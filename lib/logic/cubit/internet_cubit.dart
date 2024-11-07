import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_practice/constants/enums.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  late StreamSubscription connectivityStreamSubscription;

  InternetCubit({
    required this.connectivity,
  }) : super(InternetLoadingState()) {
    connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((result) {
      if (result.first == ConnectivityResult.wifi) {
        emitInternetConnected(ConnectionType.wifi);
      } else if (result.first == ConnectivityResult.mobile) {
        emitInternetConnected(ConnectionType.mobile);
      } else {
        emitInternetDisconnected();
      }
    });
  }

  void emitInternetConnected(ConnectionType connectionType) =>
      emit(InternetConnectedState(connectionType: connectionType));

  void emitInternetDisconnected() => emit(InternetDisconnectedState());

  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }
}

part of 'internet_cubit.dart';

abstract class InternetState {}

class InternetLoadingState extends InternetState {}

class InternetConnectedState extends InternetState {
  final ConnectionType connectionType;

  InternetConnectedState({required this.connectionType});
}

class InternetDisconnectedState extends InternetState {}

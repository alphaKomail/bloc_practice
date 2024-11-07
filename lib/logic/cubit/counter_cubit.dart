import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_practice/constants/enums.dart';
import 'package:bloc_practice/logic/cubit/internet_cubit.dart';
import 'package:equatable/equatable.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  final InternetCubit? internetCubit;
  late StreamSubscription internetStreamSubscription;

  CounterCubit({this.internetCubit}) : super(const CounterState(counter: 0)) {
    internetStreamSubscription = internetCubit!.stream.listen((internetState) {
      if (internetState is InternetConnectedState &&
          internetState.connectionType == ConnectionType.wifi) {
        incrementCounter();
      } else if (internetState is InternetConnectedState &&
          internetState.connectionType == ConnectionType.mobile) {
        decrementCounter();
      }
    });
  }

  void incrementCounter() =>
      emit(CounterState(counter: (state.counter + 1), wasIncremented: true));

  void decrementCounter() =>
      emit(CounterState(counter: (state.counter - 1), wasDecremented: true));

  @override
  Future<void> close() {
    internetStreamSubscription.cancel();
    return super.close();
  }
}

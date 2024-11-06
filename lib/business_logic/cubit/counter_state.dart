part of 'counter_cubit.dart';

class CounterState {
  final int counter;
  final bool? wasIncremented;
  final bool? wasDecremented;

  CounterState(
      {required this.counter,
      this.wasIncremented = false,
      this.wasDecremented = false});
}

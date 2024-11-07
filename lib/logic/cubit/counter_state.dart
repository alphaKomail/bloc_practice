part of 'counter_cubit.dart';

class CounterState extends Equatable {
  final int counter;
  final bool? wasIncremented;
  final bool? wasDecremented;

  const CounterState(
      {required this.counter,
      this.wasIncremented = false,
      this.wasDecremented = false});

  @override
  List<Object?> get props => [counter, wasDecremented, wasIncremented];
}

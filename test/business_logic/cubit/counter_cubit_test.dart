import 'package:bloc_practice/logic/cubit/counter_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Counter Cubit', () {
    late CounterCubit counterCubit;

    setUp(() {
      counterCubit = CounterCubit();
    });

    tearDown(() {
      counterCubit.close();
    });

    test('Initial Counter State is CounterState & Its Value is 0', () {
      expect(counterCubit.state, const CounterState(counter: 0));
    });

    blocTest<CounterCubit, CounterState>(
      'CounterState Change and Increment Function is also working and value Incremented to 1.',
      build: () => counterCubit,
      act: (bloc) => bloc.incrementCounter(),
      expect: () => [const CounterState(counter: 1, wasIncremented: true)],
    );
  });
}

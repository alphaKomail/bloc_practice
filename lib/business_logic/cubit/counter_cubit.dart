import 'package:bloc/bloc.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterState(counter: 0));

  void incrementCounter() =>
      emit(CounterState(counter: (state.counter + 1), wasIncremented: true));

  void decrementCounter() =>
      emit(CounterState(counter: (state.counter - 1), wasDecremented: true));
}

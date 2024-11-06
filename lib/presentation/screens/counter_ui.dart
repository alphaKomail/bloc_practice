import 'package:bloc_practice/business_logic/cubit/counter_cubit.dart';
import 'package:bloc_practice/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterUI extends StatefulWidget {
  const CounterUI({super.key});

  @override
  State<CounterUI> createState() => _CounterUIState();
}

class _CounterUIState extends State<CounterUI> {
  // Increments the counter by 1

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Counter'),
      ),
      body: BlocConsumer<CounterCubit, CounterState>(
        listener: (context, state) {
          if (state.wasIncremented == true) {
            Utils.snackBarMessage(context: context, message: 'Incremented');
          }
          if (state.wasDecremented == true) {
            Utils.snackBarMessage(context: context, message: 'Decremented');
          }
        },
        builder: (BuildContext context, CounterState state) => Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  state.counter.toString(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ]),
        ),
      ),
      floatingActionButton: Wrap(
        spacing: 20,
        children: [
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.exposure_plus_1_outlined),
          ),
          FloatingActionButton(
            onPressed: _decrementCounter,
            tooltip: 'Decrement',
            child: const Icon(Icons.exposure_minus_1_outlined),
          ),
        ],
      ),
    );
  }

  void _incrementCounter() {
    BlocProvider.of<CounterCubit>(context, listen: false).incrementCounter();
  }

  void _decrementCounter() {
    BlocProvider.of<CounterCubit>(context, listen: false).decrementCounter();
  }
}

import 'package:bloc_practice/logic/cubit/counter_cubit.dart';
import 'package:bloc_practice/presentation/third_screen.dart';
import 'package:bloc_practice/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  // Increments the counter by 1

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
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
                MaterialButton(
                    child: const Text(
                      'Naivgate to Third Screen',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ThirdScreen(),
                      ));
                    }),
              ]),
        ),
      ),
      floatingActionButton: Wrap(
        spacing: 20,
        children: [
          FloatingActionButton(
            heroTag: 'add',
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.exposure_plus_1_outlined),
          ),
          FloatingActionButton(
            heroTag: 'sub',
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

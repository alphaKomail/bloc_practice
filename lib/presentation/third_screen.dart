import 'package:bloc_practice/logic/cubit/counter_cubit.dart';
import 'package:bloc_practice/presentation/screens/second_screen.dart';
import 'package:bloc_practice/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  // Increments the counter by 1

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Third Screen'),
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
                      'Navigate To Second Screen',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SecondScreen(),
                      ));
                    }),
              ]),
        ),
      ),
      floatingActionButton: Wrap(
        spacing: 20,
        children: [
          FloatingActionButton(
            heroTag: 'addthird',
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.exposure_plus_1_outlined),
          ),
          FloatingActionButton(
            heroTag: 'subthird',
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

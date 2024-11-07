import 'package:bloc_practice/constants/enums.dart';
import 'package:bloc_practice/logic/cubit/counter_cubit.dart';
import 'package:bloc_practice/logic/cubit/internet_cubit.dart';
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DefaultTextStyle(
            style: Theme.of(context).textTheme.titleLarge!,
            child: BlocBuilder<InternetCubit, InternetState>(
              builder: (context, state) {
                if (state is InternetConnectedState &&
                    state.connectionType == ConnectionType.wifi) {
                  return const Text(
                      'Connected To Wifi Internet & Calling Inrement Function');
                } else if (state is InternetConnectedState &&
                    state.connectionType == ConnectionType.mobile) {
                  return const Text(
                      'Connected To Mobile Internet & Calling Decrement Function');
                } else {
                  return const Text('No Internet Connection');
                }
              },
            ),
          ),
          BlocConsumer<CounterCubit, CounterState>(
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
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    MaterialButton(
                        child: const Text(
                          'Navigate To Second Screen',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/second');
                        }),
                    MaterialButton(
                        child: const Text(
                          'Navigate To Third Screen',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/third');
                        }),
                  ]),
            ),
          ),
        ],
      ),
      floatingActionButton: Wrap(
        spacing: 20,
        children: [
          FloatingActionButton(
            heroTag: 'addhome',
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.exposure_plus_1_outlined),
          ),
          FloatingActionButton(
            heroTag: 'subhome',
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

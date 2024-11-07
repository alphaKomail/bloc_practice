import 'package:bloc_practice/logic/cubit/counter_cubit.dart';
import 'package:bloc_practice/logic/cubit/internet_cubit.dart';
import 'package:bloc_practice/utils/routes/routes.dart';
import 'package:bloc_practice/utils/routes/routes_name.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp(
    connectivity: Connectivity(),
  ));
}

class MyApp extends StatelessWidget {
  final Connectivity connectivity;

  const MyApp({super.key, required this.connectivity});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => InternetCubit(connectivity: connectivity),
        ),
        BlocProvider(
          create: (context) => CounterCubit(
              internetCubit:
                  BlocProvider.of<InternetCubit>(context, listen: false)),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          useMaterial3: false,
        ),
        initialRoute: RoutesName.home,
        onGenerateRoute: Routes.generateRoutes,
      ),
    );
  }
}

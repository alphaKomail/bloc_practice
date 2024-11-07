import 'package:bloc_practice/presentation/screens/counter_ui.dart';
import 'package:bloc_practice/presentation/screens/second_screen.dart';
import 'package:bloc_practice/presentation/third_screen.dart';
import 'package:bloc_practice/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings routes) {
    switch (routes.name) {
      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const CounterUI());

      case RoutesName.second:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SecondScreen());

      case RoutesName.third:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ThirdScreen());

      default:
        return MaterialPageRoute(
            builder: (BuildContext context) => const Scaffold(
                  body: Center(
                    child: Text('No Define Route.'),
                  ),
                ));
    }
  }
}

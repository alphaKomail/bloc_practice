import 'package:bloc_practice/presentation/screens/counter_ui.dart';
import 'package:bloc_practice/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings routes) {
    switch (routes.name) {
      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const CounterUI());

      case RoutesName.cart:
        return MaterialPageRoute(
            builder: (BuildContext context) => Text('data'));

      case RoutesName.wishlist:
        return MaterialPageRoute(
            builder: (BuildContext context) => Text('data'));

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

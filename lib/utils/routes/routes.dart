import 'package:bloc_practice/features/cart/ui/cart_ui.dart';
import 'package:bloc_practice/features/home/bloc/home_bloc.dart';
import 'package:bloc_practice/features/home/ui/home_ui.dart';
import 'package:bloc_practice/features/wishlist/ui/wishlist_ui.dart';
import 'package:bloc_practice/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings routes) {
    switch (routes.name) {
      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => BlocProvider(
                  create: (_) => HomeBloc()..add(InitialHomeEvent()),
                  child: const HomeUI(),
                ));

      case RoutesName.cart:
        return MaterialPageRoute(
            builder: (BuildContext context) => const CartUi());

      case RoutesName.wishlist:
        return MaterialPageRoute(
            builder: (BuildContext context) => const WishListUI());

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

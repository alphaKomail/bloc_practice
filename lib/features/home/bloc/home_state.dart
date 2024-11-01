part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {
  final List<GroceryItem> groceryData;
  final List<GroceryItem> cartItems;
  final List<GroceryItem> wishlistItems;

  HomeLoadedSuccessState({
    required this.groceryData,
    required this.cartItems,
    required this.wishlistItems,
  });
}

class CartListNavigationActionState extends HomeState {}

class WishListNavigationActionState extends HomeState {}

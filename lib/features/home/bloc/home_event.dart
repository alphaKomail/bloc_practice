part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class InitialHomeEvent extends HomeEvent {}

class CartListButtonClickedEvent extends HomeEvent {}

class WishListButtonClickedEvent extends HomeEvent {}

class CartListPageNavigationButtonClickedEvent extends HomeEvent {}

class WishListPageNavigationButtonClickedEvent extends HomeEvent {}

class AddToCartEvent extends HomeEvent {
  final GroceryItem item;

  AddToCartEvent({required this.item});
}

class AddToWishlistEvent extends HomeEvent {
  final GroceryItem item;

  AddToWishlistEvent({required this.item});
}

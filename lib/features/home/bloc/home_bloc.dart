import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_practice/data/grocery_data.dart';
import 'package:bloc_practice/features/home/model/product_data_model.dart';
import 'package:flutter/material.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<InitialHomeEvent>(_onInitialHomeFetchData);
    on<CartListPageNavigationButtonClickedEvent>(
        (event, emit) => emit(CartListNavigationActionState()));
    on<WishListPageNavigationButtonClickedEvent>(
        (event, emit) => emit(WishListNavigationActionState()));
    on<AddToCartEvent>(_onAddToCart);
    on<AddToWishlistEvent>(_onAddToWishlist);
  }

  FutureOr<void> _onInitialHomeFetchData(
      InitialHomeEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 3));
    final groceryItems = GroceryData.groceryProducts
        .map((item) => GroceryItem.fromMap(item))
        .toList();
    emit(HomeLoadedSuccessState(
        groceryData: groceryItems,
        cartItems: const [],
        wishlistItems: const []));
  }

  void _onAddToCart(AddToCartEvent event, Emitter<HomeState> emit) {
    if (state is HomeLoadedSuccessState) {
      final currentState = state as HomeLoadedSuccessState;
      final updatedCart = List<GroceryItem>.from(currentState.cartItems)
        ..add(event.item);
      emit(HomeLoadedSuccessState(
        groceryData: currentState.groceryData,
        cartItems: updatedCart,
        wishlistItems: currentState.wishlistItems,
      ));
    }
  }

  void _onAddToWishlist(AddToWishlistEvent event, Emitter<HomeState> emit) {
    if (state is HomeLoadedSuccessState) {
      final currentState = state as HomeLoadedSuccessState;
      final updatedWishlist = List<GroceryItem>.from(currentState.wishlistItems)
        ..add(event.item);
      emit(HomeLoadedSuccessState(
        groceryData: currentState.groceryData,
        cartItems: currentState.cartItems,
        wishlistItems: updatedWishlist,
      ));
    }
  }
}

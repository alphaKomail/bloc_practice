import 'package:bloc_practice/features/home/bloc/home_bloc.dart';
import 'package:bloc_practice/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeUI extends StatefulWidget {
  const HomeUI({super.key});

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  @override
  Widget build(BuildContext context) {
    // Access the HomeBloc from the context
    final homeBloc = BlocProvider.of<HomeBloc>(context);

    return BlocConsumer<HomeBloc, HomeState>(
      listenWhen: (previous, current) =>
          current is WishListNavigationActionState ||
          current is CartListNavigationActionState,
      buildWhen: (previous, current) =>
          current is! HomeInitial && current is! HomeLoadingState,
      listener: (context, state) {
        if (state is WishListNavigationActionState) {
          Navigator.of(context).pushNamed(RoutesName.wishlist);
        } else if (state is CartListNavigationActionState) {
          Navigator.of(context).pushNamed(RoutesName.cart);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Grocery Store'),
            actions: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  homeBloc.add(CartListPageNavigationButtonClickedEvent());
                },
              ),
              IconButton(
                icon: const Icon(Icons.favorite),
                onPressed: () {
                  homeBloc.add(WishListPageNavigationButtonClickedEvent());
                },
              ),
            ],
          ),
          body: _buildBody(state),
        );
      },
    );
  }

  Widget _buildBody(HomeState state) {
    if (state is HomeLoadingState) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is HomeLoadedSuccessState) {
      return _buildGroceryList(state);
    }
    return const Center(child: Text('No items available'));
  }

  Widget _buildGroceryList(HomeLoadedSuccessState state) {
    return ListView.separated(
      itemCount: state.groceryData.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final item = state.groceryData[index];
        return ListTile(
          minVerticalPadding: 12,
          tileColor: Colors.grey.shade200,
          title: Text(item.name),
          subtitle: Text('${item.category} • \$${item.price}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {
                  BlocProvider.of<HomeBloc>(context)
                      .add(AddToWishlistEvent(item: item));
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.add_shopping_cart,
                  color: item.inStock ? null : Colors.grey,
                ),
                onPressed: item.inStock
                    ? () {
                        BlocProvider.of<HomeBloc>(context)
                            .add(AddToCartEvent(item: item));
                      }
                    : null,
              ),
            ],
          ),
          leading: item.inStock
              ? const Icon(Icons.check_circle, color: Colors.green)
              : const Icon(Icons.error, color: Colors.red),
        );
      },
      separatorBuilder: (BuildContext context, int index) => Divider(
        height: 6,
        color: Colors.grey.shade100,
      ),
    );
  }
}

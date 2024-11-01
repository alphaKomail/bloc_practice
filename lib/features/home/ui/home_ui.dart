import 'package:bloc_practice/features/home/bloc/home_bloc.dart';
import 'package:bloc_practice/features/home/model/product_data_model.dart';
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
  void initState() {
    super.initState();
    // Dispatch an event to load initial data
    context.read<HomeBloc>().add(InitialHomeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listenWhen: (previous, current) =>
          current is WishListNavigationActionState ||
          current is CartListNavigationActionState,
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
              _buildActionIcon(Icons.shopping_cart, () {
                context
                    .read<HomeBloc>()
                    .add(CartListPageNavigationButtonClickedEvent());
              }),
              _buildActionIcon(Icons.favorite, () {
                context
                    .read<HomeBloc>()
                    .add(WishListPageNavigationButtonClickedEvent());
              }),
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
    }

    if (state is HomeLoadedSuccessState) {
      return _buildGroceryList(
          state.groceryData, state.cartItems, state.wishlistItems);
    }

    if (state is HomeErrorState) {
      return Center(child: Text('Error: ${state.message}'));
    }

    return const SizedBox.shrink();
  }

  Widget _buildGroceryList(List<GroceryItem> groceryData,
      List<GroceryItem> cartItems, List<GroceryItem> wishlistItems) {
    return ListView.separated(
      itemCount: groceryData.length,
      itemBuilder: (context, index) =>
          _buildGroceryItem(groceryData[index], cartItems, wishlistItems),
      separatorBuilder: (context, index) =>
          Divider(height: 6, color: Colors.grey.shade100),
    );
  }

  Widget _buildGroceryItem(GroceryItem item, List<GroceryItem> cartItems,
      List<GroceryItem> wishlistItems) {
    final isInCart = cartItems.contains(item);
    final isInWishlist = wishlistItems.contains(item);

    return ListTile(
      minVerticalPadding: 12,
      tileColor: Colors.grey.shade200,
      title: Text(item.name),
      subtitle: Text('${item.category} • \$${item.price}'),
      trailing: GroceryItemActions(
          item: item, isInWishlist: isInWishlist, isInCart: isInCart),
      leading: Icon(
        item.inStock ? Icons.check_circle : Icons.error,
        color: item.inStock ? Colors.green : Colors.red,
      ),
    );
  }

  Widget _buildActionIcon(IconData icon, VoidCallback onPressed) {
    return IconButton(icon: Icon(icon), onPressed: onPressed);
  }
}

class GroceryItemActions extends StatelessWidget {
  final GroceryItem item;
  final bool isInWishlist;
  final bool isInCart;

  const GroceryItemActions(
      {super.key,
      required this.item,
      required this.isInWishlist,
      required this.isInCart});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(isInWishlist ? Icons.favorite : Icons.favorite_border),
          onPressed: () =>
              context.read<HomeBloc>().add(AddToWishlistEvent(item: item)),
        ),
        IconButton(
          icon: Icon(Icons.add_shopping_cart,
              color: item.inStock ? null : Colors.grey),
          onPressed: item.inStock && !isInCart
              ? () => context.read<HomeBloc>().add(AddToCartEvent(item: item))
              : null,
        ),
      ],
    );
  }
}

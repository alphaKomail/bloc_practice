class GroceryItem {
  final String name;
  final String category;
  final double price;
  final int quantity;
  final bool inStock;

  GroceryItem({
    required this.name,
    required this.category,
    required this.price,
    required this.quantity,
    required this.inStock,
  });

  // Factory constructor to create a GroceryItem from a map
  factory GroceryItem.fromMap(Map<String, dynamic> data) {
    return GroceryItem(
      name: data['name'] as String,
      category: data['category'] as String,
      price: data['price'] as double,
      quantity: data['quantity'] as int,
      inStock: data['inStock'] as bool,
    );
  }

  // Method to convert GroceryItem to a map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'price': price,
      'quantity': quantity,
      'inStock': inStock,
    };
  }
}

extension GroceryItemExtensions on GroceryItem {
  bool isInCart(List<GroceryItem> cartItems) => cartItems.contains(this);
  bool isInWishlist(List<GroceryItem> wishlistItems) =>
      wishlistItems.contains(this);
}

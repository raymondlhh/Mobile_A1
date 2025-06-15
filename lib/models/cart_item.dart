import 'menu_item.dart';

class CartItem {
  final MenuItem menuItem;
  int quantity;

  CartItem({required this.menuItem, this.quantity = 1});

  double get totalPrice {
    // Extract numeric value from price string (e.g., "RM 15.90" -> 15.90)
    final priceString = menuItem.price.replaceAll(RegExp(r'[^0-9.]'), '');
    return double.parse(priceString) * quantity;
  }
}

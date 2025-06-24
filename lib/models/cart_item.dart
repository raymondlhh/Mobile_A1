import 'menu_item.dart';

class CartItem {
  final MenuItem menuItem;
  int quantity;

  CartItem({required this.menuItem, this.quantity = 1});

  double get totalPrice {
    // Remove 'RM ' prefix and convert to double
    final priceStr = menuItem.price.replaceAll('RM ', '');
    return double.parse(priceStr) * quantity;
  }
}

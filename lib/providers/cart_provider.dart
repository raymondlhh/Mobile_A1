import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../models/menu_item.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  double get totalAmount {
    return _items.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  void addItem(MenuItem menuItem, int quantity) {
    final existingIndex = _items.indexWhere(
      (item) => item.menuItem.name == menuItem.name,
    );

    if (existingIndex >= 0) {
      // Item exists, update quantity
      _items[existingIndex].quantity += quantity;
    } else {
      // Add new item
      _items.add(CartItem(menuItem: menuItem, quantity: quantity));
    }
    notifyListeners();
  }

  void removeItem(String itemName) {
    _items.removeWhere((item) => item.menuItem.name == itemName);
    notifyListeners();
  }

  void updateQuantity(String itemName, int quantity) {
    final index = _items.indexWhere((item) => item.menuItem.name == itemName);
    if (index >= 0) {
      if (quantity > 0) {
        _items[index].quantity = quantity;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }
}

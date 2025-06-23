import 'package:flutter/foundation.dart';
import '../models/menu_item.dart';

class FavouriteService extends ChangeNotifier {
  static final FavouriteService _instance = FavouriteService._internal();
  factory FavouriteService() => _instance;
  FavouriteService._internal();

  final List<MenuItem> _favouriteItems = [];

  List<MenuItem> get favouriteItems => _favouriteItems;

  bool isFavourite(MenuItem item) {
    return _favouriteItems.any((i) => i.name == item.name);
  }

  void toggleFavourite(MenuItem item) {
    if (isFavourite(item)) {
      _favouriteItems.removeWhere((i) => i.name == item.name);
    } else {
      _favouriteItems.add(item);
    }
    notifyListeners();
  }
}
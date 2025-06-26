import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/menu_item.dart';
import '../models/user_profile.dart';

class FavouriteService extends ChangeNotifier {
  static final FavouriteService _instance = FavouriteService._internal();
  factory FavouriteService() => _instance;
  FavouriteService._internal();

  final List<MenuItem> _favouriteItems = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<MenuItem> get favouriteItems => _favouriteItems;

  bool isFavourite(MenuItem item) {
    return _favouriteItems.any((i) => i.name == item.name);
  }

  Future<void> loadFavourites() async {
    final userId = UserProfile.userId;
    if (userId.isEmpty) return;
    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('favourites')
        .get();
    _favouriteItems.clear();
    for (var doc in snapshot.docs) {
      _favouriteItems.add(MenuItem.fromJson(doc.data()));
    }
    notifyListeners();
  }

  Future<void> saveFavourite(MenuItem item) async {
    final userId = UserProfile.userId;
    if (userId.isEmpty) return;
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('favourites')
        .doc(item.name)
        .set(item.toJson());
  }

  Future<void> removeFavourite(MenuItem item) async {
    final userId = UserProfile.userId;
    if (userId.isEmpty) return;
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('favourites')
        .doc(item.name)
        .delete();
  }

  Future<void> toggleFavourite(MenuItem item) async {
    if (isFavourite(item)) {
      _favouriteItems.removeWhere((i) => i.name == item.name);
      await removeFavourite(item);
    } else {
      _favouriteItems.add(item);
      await saveFavourite(item);
    }
    notifyListeners();
  }

  /// One-time migration: Move all docs from global 'favouriteItems' to per-user subcollections
  static Future<void> migrateFavouriteItemsToUserSubcollections() async {
    final firestore = FirebaseFirestore.instance;
    final favouriteItemsCollection = firestore.collection('favouriteItems');
    final usersCollection = firestore.collection('users');

    final snapshot = await favouriteItemsCollection.get();

    for (var doc in snapshot.docs) {
      final data = doc.data();
      final userId = data['userId'];
      final menuItem = data['menuItem']; // or adjust if your field is different

      if (userId != null && menuItem != null) {
        final menuItemId = menuItem['name'] ?? doc.id;
        await usersCollection
            .doc(userId)
            .collection('favourites')
            .doc(menuItemId)
            .set(menuItem);
        // Optionally, delete the old document
        await doc.reference.delete();
      }
    }
    print('Favourite items migration complete!');
  }
}
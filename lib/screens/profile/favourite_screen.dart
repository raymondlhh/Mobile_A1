import 'package:flutter/material.dart';
import '../../models/favourite_food.dart';
import '../../widgets/title_appbar.dart';
import '../../widgets/favourite_food_card.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  // ignore: prefer_final_fields
  List<FavouriteFood> _foods = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    setState(() {});
  }

  Future<void> _removeFromFavourites(FavouriteFood food) async {
    await _loadFavorites(); // Reload the list after deletion
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        'Favourites',
        actionType: AppBarActionType.none,
      ),
      body:
          _foods.isEmpty
              ? const Center(
                child: Text('No favorites yet', style: TextStyle(fontSize: 18)),
              )
              : ListView.builder(
                itemCount: _foods.length,
                padding: const EdgeInsets.all(22),
                itemBuilder: (context, index) {
                  return FavouriteFoodCard(
                    food: _foods[index],
                    onRemove: () => _removeFromFavourites(_foods[index]),
                  );
                },
              ),
    );
  }
}

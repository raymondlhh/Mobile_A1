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
  // Start with reversed list: newest on top
  // ignore: prefer_final_fields
  List<FavouriteFood> _foods = List.from(favouriteFoods.reversed);

  void _removeFromFavourites(FavouriteFood food) {
    setState(() {
      _foods.remove(food); // this will cause the items below to move up
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Favourites', actionType: AppBarActionType.none),
      body: ListView.builder(
        itemCount: _foods.length,
        padding: const EdgeInsets.all(20),
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

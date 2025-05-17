import 'package:flutter/material.dart';
import '../../models/favourite_food.dart';

class FavouriteFoodCard extends StatelessWidget {
  final FavouriteFood food;
  final VoidCallback? onRemove;

  const FavouriteFoodCard({super.key, required this.food, this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      child: Stack(
        children: [
          Image.asset(
            'assets/images/others/FavouriteFoodBackground.png',
            width: double.infinity,
            height: 130,
            fit: BoxFit.contain,
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    food.imagePath,
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        food.name,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/others/Star.png',
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            food.rating.toString(),
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '(${food.totalRating})',
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: onRemove,
                  child: Image.asset(
                    'assets/images/others/FoodSave.png',
                    width: 53,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

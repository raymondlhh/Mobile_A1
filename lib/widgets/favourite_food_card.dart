import 'package:flutter/material.dart';
import '../../models/favourite_food.dart';

class FavouriteFoodCard extends StatelessWidget {
  final FavouriteFood food;
  final VoidCallback? onRemove;

  const FavouriteFoodCard({super.key, required this.food, this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Stack(
        children: [
          Image.asset(
            'assets/images/others/FavouriteFoodBackground.png',
            width: double.infinity,
            height: 120,
            fit: BoxFit.contain,
          ),
          Padding(
            padding: const EdgeInsets.all(12),
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
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        food.name,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/others/Star.png',
                            width: 17,
                            height: 17,
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

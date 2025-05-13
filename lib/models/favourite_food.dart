//import 'package:flutter/material.dart';

class FavouriteFood {
  final String name;
  final double rating;
  final String totalRating;
  final String imagePath;

  FavouriteFood({
    required this.name,
    required this.rating,
    required this.totalRating,
    required this.imagePath,
  });
}

// Dummy data
List<FavouriteFood> favouriteFoods = [
  FavouriteFood(
    name: 'Party Set A',
    rating: 3.8,
    totalRating: '118+ Rating',
    imagePath: 'assets/images/foods/party_set/party_set_a.png',
  ),

  FavouriteFood(
    name: 'Chuka Idako',
    rating: 4.5,
    totalRating: '90+ Rating',
    imagePath: 'assets/images/foods/appetizers/chuka_idako.png',
  ),

  FavouriteFood(
    name: 'Party Set B',
    rating: 3.5,
    totalRating: '110+ Rating',
    imagePath: 'assets/images/foods/party_set/party_set_b.png',
  ),

  
];

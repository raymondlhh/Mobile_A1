import 'package:flutter/foundation.dart';

@immutable
class Review {
  final String reviewerName;
  final String reviewerAvatar;
  final String comment;

  const Review({
    required this.reviewerName,
    required this.reviewerAvatar,
    required this.comment,
  });

  Map<String, dynamic> toJson() => {
    'reviewerName': reviewerName,
    'reviewerAvatar': reviewerAvatar,
    'comment': comment,
  };
}

@immutable
class MenuItem {
  final String name;
  final String price;
  final double ratings;
  final List<Review> reviews;
  final String description;
  final String imagePath;

  const MenuItem({
    required this.name,
    required this.price,
    required this.ratings,
    required this.reviews,
    required this.description,
    required this.imagePath,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'price': price,
    'ratings': ratings,
    'reviews': reviews.map((r) => r.toJson()).toList(),
    'description': description,
    'imagePath': imagePath,
  };
}

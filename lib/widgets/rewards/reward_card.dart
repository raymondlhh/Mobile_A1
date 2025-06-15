import 'package:flutter/material.dart';
import '../../screens/rewards/reward_detail_page.dart';

class RewardCard extends StatelessWidget {
  final String id;
  final String imagePath;
  final String itemName;
  final String description;
  final int points;
  final int validity;

  const RewardCard({
    super.key,
    required this.id,
    required this.imagePath,
    required this.itemName,
    required this.description,
    required this.points,
    required this.validity,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => RedeemPage(
                  id: id,
                  imagePath: imagePath,
                  itemName: itemName,
                  description: description,
                  points: points,
                  validity: validity,
                ),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: 100,
          decoration: BoxDecoration(
            color: const Color(0xFF8AB98F),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 8),
              Container(
                width: 125,
                height: 115,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFCA3202), width: 10),
                ),
                child: Image.asset(imagePath, fit: BoxFit.cover),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF7F7F7F), width: 1),
                ),
                child: Text(
                  '$points pts',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                itemName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 13,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../screens/rewards/reward_detail_page.dart';

class RewardCard extends StatelessWidget {
  final String id;
  final String imagePath;
  final String itemName;
  final String description;
  final int points;
  final int validity;
  final int userPoints;

  const RewardCard({
    super.key,
    required this.id,
    required this.imagePath,
    required this.itemName,
    required this.description,
    required this.points,
    required this.validity,
    required this.userPoints,
  });

  bool get canAfford => userPoints >= points;

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
                  userPoints: userPoints,
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
            color: canAfford ? const Color(0xFF8AB98F) : Colors.grey.shade400,
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
                  border: Border.all(
                    color:
                        canAfford
                            ? const Color(0xFFCA3202)
                            : Colors.grey.shade600,
                    width: 10,
                  ),
                ),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  color: canAfford ? null : Colors.grey.shade400,
                  colorBlendMode: canAfford ? null : BlendMode.saturation,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: canAfford ? Colors.white : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color:
                        canAfford
                            ? const Color(0xFF7F7F7F)
                            : Colors.grey.shade400,
                    width: 1,
                  ),
                ),
                child: Text(
                  '$points pts',
                  style: TextStyle(
                    color: canAfford ? Colors.black : Colors.grey.shade600,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                itemName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: canAfford ? Colors.black : Colors.grey.shade600,
                  fontSize: 13,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (!canAfford) ...[
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Need ${points - userPoints} more pts',
                    style: TextStyle(
                      color: Colors.red.shade800,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

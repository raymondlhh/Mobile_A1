import 'package:flutter/material.dart';
import '../../widgets/title_appbar.dart';
import '../../services/database_service.dart';
import '../../models/user_profile.dart';

class RedeemPage extends StatelessWidget {
  final String id;
  final String imagePath;
  final String itemName;
  final String description;
  final int points;
  final int validity;
  final int userPoints;

  const RedeemPage({
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

  Future<void> _handleRedeem(BuildContext context) async {
    if (!canAfford) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Insufficient points. You need ${points - userPoints} more points.',
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      final databaseService = DatabaseService();

      // Use user ID if available, otherwise fall back to email
      if (UserProfile.userId.isNotEmpty) {
        await databaseService.redeemRewardWithPointsById(
          id,
          UserProfile.userId,
        );
      } else {
        await databaseService.redeemRewardWithPoints(id, UserProfile.email);
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Reward redeemed successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error redeeming reward: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F3E7),
      appBar: buildAppBar(context, 'MY REWARDS'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: const Color(0xFFA9CBA0),
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFD24545),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Image.asset(
                      imagePath,
                      width: 120,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    itemName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Points Required',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('${points}Pts'),
                  const SizedBox(height: 8),
                  const Text(
                    'Your Current Points',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${userPoints}Pts',
                    style: TextStyle(
                      color: canAfford ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (!canAfford) ...[
                    const SizedBox(height: 4),
                    Text(
                      'You need ${points - userPoints} more points to redeem this reward',
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ],
                  const SizedBox(height: 8),
                  const Text(
                    'Validity (per month)',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('$validity'),
                  const SizedBox(height: 12),
                  const Text(
                    'Terms and Conditions',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '• Reward points can only be redeemed for available rewards as displayed within the app.',
                  ),
                  const Text(
                    '• The number of points required for each reward is clearly indicated.',
                  ),
                  const Text(
                    '• Rewards are subject to availability and may change without prior notice.',
                  ),
                  const Text(
                    '• Once points are redeemed for a reward, the redemption cannot be reversed or refunded.',
                  ),
                  const Text(
                    '• Reward points have no cash value and cannot be exchanged for cash.',
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      canAfford ? const Color(0xFFD24545) : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size.fromHeight(48),
                ),
                onPressed: canAfford ? () => _handleRedeem(context) : null,
                child: Text(
                  canAfford ? 'Redeem' : 'Insufficient Points',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

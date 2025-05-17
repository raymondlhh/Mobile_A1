import 'package:flutter/material.dart';
import '../../widgets/title_appbar.dart';

class RedeemPage extends StatelessWidget {
  final String imagePath;
  final String itemName;
  final String description;
  final int points;
  final int validity;

  const RedeemPage({
    super.key,
    required this.imagePath,
    required this.itemName,
    required this.description,
    required this.points,
    required this.validity,
  });

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
                    'Points',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('${points}Pts'),
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
                  backgroundColor: const Color(0xFFD24545),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size.fromHeight(48),
                ),
                onPressed: () {},
                child: const Text(
                  'Redeem',
                  style: TextStyle(
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

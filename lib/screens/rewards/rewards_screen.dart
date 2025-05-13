/* // lib/screens/home/rewards_screen.dart
//test
import 'package:flutter/material.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key}); // FIX key constructor

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Rewards Screen', style: TextStyle(fontSize: 24)),
    );
  }
} */

// ... existing code ...
import 'package:flutter/material.dart';

import '../../widgets/title_appbar.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F3E7),
      appBar: buildAppBar(context, 'MY REWARDS'),
      body: Column(
        children: [
          // Rewards Points Card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.grey.shade400, width: 2),
              ),
              child: Stack(
                children: [
                  // You can use a background image here if you have one
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Rewards Point:',
                          style: TextStyle(fontSize: 18, color: Colors.black87),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '3688 Pts',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Rewards Cards
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _rewardCard(
                  context,
                  'assets/images/rewardsfood/Reward1.png',
                  'Chuka Wakame',
                  'Seaweed salad with a subtly sweet and savory flavor.',
                  1500,
                  8,
                ),
                _rewardCard(
                  context,
                  'assets/images/rewardsfood/Reward2.png',
                  'Salmon Moriawase',
                  'Assorted fresh salmon sashimi.',
                  2000,
                  6,
                ),
                _rewardCard(
                  context,
                  'assets/images/rewardsfood/Reward3.png',
                  'Chicken Teriyaki Ramen',
                  'Ramen with chicken teriyaki and vegetables.',
                  1800,
                  7,
                ),
                _rewardCard(
                  context,
                  'assets/images/rewardsfood/Reward4.png',
                  'Ebi Tempura',
                  'Crispy battered shrimp tempura.',
                  1700,
                  5,
                ),
              ],
            ),
          ),
          const Spacer(),
          // How It Works Section
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'How It Works',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _howItWorksItem(
                      Icons.shopping_bag,
                      'Earn rewards points\nevery order',
                    ),
                    _howItWorksItem(
                      Icons.redeem,
                      'Redeem rewards with\nyour rewards points',
                    ),
                    _howItWorksItem(Icons.card_giftcard, 'Enjoy your rewards!'),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  color: const Color(0xFFA9CBA0),
                  child: ListTile(
                    title: const Text(
                      'FAQ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _rewardCard(
    BuildContext context,
    String imagePath,
    String itemName,
    String description,
    int points,
    int validity,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => RedeemPage(
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
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: 100,
          height: 180,
          decoration: BoxDecoration(
            color: const Color(0xFFA9CBA0),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 80,
                height: 70,
                decoration: BoxDecoration(
                  color: const Color(0xFFD24545),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.asset(imagePath, fit: BoxFit.cover),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.brown, width: 1),
                ),
                child: Text(
                  '${points} pts',
                  style: const TextStyle(
                    color: Colors.brown,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                itemName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _howItWorksItem(IconData icon, String text) {
    return Column(
      children: [
        Icon(icon, size: 32, color: Colors.brown),
        const SizedBox(height: 4),
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}

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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'MY REWARDS',
          style: TextStyle(
            fontFamily: 'Caveat',
            fontWeight: FontWeight.bold,
            fontSize: 26,
            color: Colors.black,
            letterSpacing: 2,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.black),
      ),
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

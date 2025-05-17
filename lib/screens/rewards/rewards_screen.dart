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
import 'reward_detail_page.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F3E7),
      appBar: buildAppBar(context, 'MY REWARDS'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Rewards Points Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.grey.shade400, width: 2),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Rewards Point:',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            '3688 Pts',
                            style: TextStyle(
                              fontSize: 28,
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
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                final rewards = [
                  {
                    'image': 'assets/images/rewardsfood/Reward1.png',
                    'name': 'Chuka Wakame',
                    'description':
                        'Seaweed salad with a subtly sweet and savory flavor.',
                    'points': 1500,
                    'validity': 8,
                  },
                  {
                    'image': 'assets/images/rewardsfood/Reward2.png',
                    'name': 'Salmon Moriawase',
                    'description': 'Assorted fresh salmon sashimi.',
                    'points': 2000,
                    'validity': 6,
                  },
                  {
                    'image': 'assets/images/rewardsfood/Reward3.png',
                    'name': 'Chicken Teriyaki Ramen',
                    'description':
                        'Ramen with chicken teriyaki and vegetables.',
                    'points': 1800,
                    'validity': 7,
                  },
                  {
                    'image': 'assets/images/rewardsfood/Reward4.png',
                    'name': 'Ebi Tempura',
                    'description': 'Crispy battered shrimp tempura.',
                    'points': 1700,
                    'validity': 5,
                  },
                ];

                final reward = rewards[index];
                return _rewardCard(
                  context,
                  reward['image'] as String,
                  reward['name'] as String,
                  reward['description'] as String,
                  reward['points'] as int,
                  reward['validity'] as int,
                );
              },
            ),
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
                      _howItWorksItem(
                        Icons.card_giftcard,
                        'Enjoy your rewards!',
                      ),
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
          height: 160,
          decoration: BoxDecoration(
            color: const Color(0xFFA9CBA0),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              const SizedBox(height: 8),
              Container(
                width: 70,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFFD24545),
                  borderRadius: BorderRadius.circular(16),
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
                  border: Border.all(color: Colors.brown, width: 1),
                ),
                child: Text(
                  '${points} pts',
                  style: const TextStyle(
                    color: Colors.brown,
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
                  color: Colors.black87,
                  fontSize: 11,
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

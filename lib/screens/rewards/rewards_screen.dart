import 'package:flutter/material.dart';
import '../../widgets/title_appbar.dart';
import 'reward_detail_page.dart';
import 'faq_screen.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E5),
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
                  border: Border.all(color: const Color(0xFF7F7F7F), width: 2),
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
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                final rewards = [
                  {
                    'image': 'assets/images/foods/appetizers/chuka_wakame.png',
                    'name': 'Chuka Wakame',
                    'description':
                        'Seaweed salad with a subtly sweet and savory flavor.',
                    'points': 1500,
                    'validity': 8,
                  },
                  {
                    'image':
                        'assets/images/foods/curry_sets/ebi_curry_udon.png',
                    'name': 'Ebi Curry Udon',
                    'description': 'Curry udon with ebi tempura.',
                    'points': 2000,
                    'validity': 6,
                  },
                  {
                    'image':
                        'assets/images/foods/ramen/chicken_teriyaki_ramen.png',
                    'name': 'Chicken Teriyaki Ramen',
                    'description':
                        'Ramen with chicken teriyaki and vegetables.',
                    'points': 1800,
                    'validity': 7,
                  },
                  {
                    'image': 'assets/images/foods/tempura/ebi_tempura.png',
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
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xFF000000),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _howItWorksItem(
                        'assets/images/icons/reward_icon/left_icon.png',
                        'Earn rewards points\nevery order',
                      ),
                      _howItWorksItem(
                        'assets/images/icons/reward_icon/middle_icon.png',
                        'Redeem rewards with\nyour rewards points',
                      ),
                      _howItWorksItem(
                        'assets/images/icons/reward_icon/right_icon.png',
                        'Enjoy the amazing\nrewards!',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // FAQ Bar (full width)
            Container(
              width: double.infinity,
              color: const Color(0xFF8AB98F),
              child: ListTile(
                title: const Text(
                  'FAQ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000),
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Color(0xFF000000),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FAQScreen()),
                  );
                },
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
                  border: Border.all(color: Color(0xFFCA3202), width: 10),
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
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF7F7F7F), width: 1),
                ),
                child: Text(
                  '${points} pts',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
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
                  color: Color(0xFF000000),
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

  Widget _howItWorksItem(String iconPath, String text) {
    return Column(
      children: [
        Image.asset(iconPath, width: 32, height: 32),
        const SizedBox(height: 4),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 11, color: Color(0xFF000000)),
        ),
      ],
    );
  }
}

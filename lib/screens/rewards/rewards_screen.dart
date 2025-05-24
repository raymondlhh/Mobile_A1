import 'package:flutter/material.dart';
import '../../widgets/title_appbar.dart';
import '../../widgets/rewards/rewards_points_card.dart';
import '../../widgets/rewards/reward_card.dart';
import '../../widgets/rewards/how_it_works_section.dart';
import '../../widgets/rewards/faq_container.dart';

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
            const RewardsPointsCard(points: 3688),
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
                return RewardCard(
                  imagePath: reward['image'] as String,
                  itemName: reward['name'] as String,
                  description: reward['description'] as String,
                  points: reward['points'] as int,
                  validity: reward['validity'] as int,
                );
              },
            ),
            const HowItWorksSection(),
            const FAQContainer(),
          ],
        ),
      ),
    );
  }
}

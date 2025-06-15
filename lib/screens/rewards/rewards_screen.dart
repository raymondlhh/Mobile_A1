import 'package:flutter/material.dart';
import '../../widgets/title_appbar.dart';
import '../../widgets/rewards/rewards_points_card.dart';
import '../../widgets/rewards/reward_card.dart';
import '../../widgets/rewards/how_it_works_section.dart';
import '../../widgets/rewards/faq_container.dart';
import '../../services/database_service.dart';
import '../../models/reward.dart';

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
            FutureBuilder<List<Reward>>(
              future: DatabaseService().getAvailableRewards(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No rewards available'));
                }

                final rewards = snapshot.data!;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: rewards.length,
                  itemBuilder: (context, index) {
                    final reward = rewards[index];
                    return RewardCard(
                      id: reward.id,
                      imagePath: reward.imagePath,
                      itemName: reward.name,
                      description: reward.description,
                      points: reward.points,
                      validity: reward.validity,
                    );
                  },
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

import 'package:flutter/material.dart';
import '../../widgets/title_appbar.dart';
import '../../widgets/rewards/rewards_points_card.dart';
import '../../widgets/rewards/reward_card.dart';
import '../../widgets/rewards/how_it_works_section.dart';
import '../../widgets/rewards/faq_container.dart';
import '../../services/database_service.dart';
import '../../services/rewards_service.dart';
import '../../models/reward.dart';
import '../../models/user_profile.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  final RewardsService _rewardsService = RewardsService();
  int _userPoints = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserPoints();
  }

  Future<void> _loadUserPoints() async {
    try {
      // First try to get points from UserProfile
      _userPoints = _rewardsService.getCurrentUserPoints();

      // If UserProfile has no email or points are 0, refresh from database
      if (UserProfile.email.isEmpty || _userPoints == 0) {
        await _rewardsService.refreshCurrentUserPoints();
        _userPoints = _rewardsService.getCurrentUserPoints();
      }
    } catch (e) {
      debugPrint('Error loading user points: $e');
      _userPoints = 0;
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E5),
      appBar: buildAppBar(context, 'MY REWARDS'),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                onRefresh: _loadUserPoints,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      RewardsPointsCard(points: _userPoints),
                      FutureBuilder<List<Reward>>(
                        future: DatabaseService().getAvailableRewards(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          }

                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return const Center(
                              child: Text('No rewards available'),
                            );
                          }

                          final rewards = snapshot.data!;
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 4,
                            ),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
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
                                userPoints: _userPoints,
                                maxRedemptions: reward.maxRedemptions,
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
              ),
    );
  }
}

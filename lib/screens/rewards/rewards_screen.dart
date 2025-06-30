import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../widgets/title_appbar.dart';
import '../../widgets/rewards/rewards_points_card.dart';
import '../../widgets/rewards/reward_card.dart';
import '../../widgets/rewards/redeemed_reward_card.dart';
import '../../widgets/rewards/how_it_works_section.dart';
import '../../widgets/rewards/faq_container.dart';
import '../../services/database_service.dart';
import '../../services/rewards_service.dart';
import '../../models/reward.dart';
import '../../models/user_reward_redemption.dart';
import '../../models/users.dart';
import '../../models/user_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  final RewardsService _rewardsService = RewardsService();
  int _userPoints = 0;
  bool _isLoading = true;
  bool _showAvailableRewards = true; //Toggle between available and redeemed

  @override
  void initState() {
    super.initState();
    _loadUserPoints();
    _loadUserId();
  }

  Future<void> _loadUserPoints() async {
    try {
      //Get points from UserProfile
      _userPoints = _rewardsService.getCurrentUserPoints();

      if (UserProfile.email.isEmpty || _userPoints == 0) {
        await _rewardsService.refreshCurrentUserPoints();
        _userPoints = _rewardsService.getCurrentUserPoints();
      }
    } catch (e) {
      _userPoints = 0;
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _loadUserId() async {
    try {
      if (UserProfile.userId.isEmpty && UserProfile.email.isNotEmpty) {
        // Load user ID from database using email
        final user = await DatabaseService().getCurrentUser();
        if (user != null) {
          UserProfile.userId = user.userId;
        }
      }
    } catch (e) {
      // Error loading user ID
    }
  }

  //Method to refresh the entire screen after redemption
  Future<void> _refreshAfterRedemption() async {
    setState(() {
      _isLoading = true;
    });

    //Refresh user points from the database
    await _rewardsService.refreshCurrentUserPoints();
    _userPoints = _rewardsService.getCurrentUserPoints();

    setState(() {
      _isLoading = false;
    });
  }

  Widget _buildToggleButtons() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: const Color(0xFF7F7F7F), width: 2),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _showAvailableRewards = true;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color:
                      _showAvailableRewards
                          ? const Color(0xFF8AB98F)
                          : Colors.transparent,
                  borderRadius: BorderRadius.circular(23),
                ),
                child: Text(
                  'Available Rewards',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:
                        _showAvailableRewards ? Colors.white : Colors.black87,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _showAvailableRewards = false;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color:
                      !_showAvailableRewards
                          ? const Color(0xFF8AB98F)
                          : Colors.transparent,
                  borderRadius: BorderRadius.circular(23),
                ),
                child: Text(
                  'Redeemed Rewards',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:
                        !_showAvailableRewards ? Colors.white : Colors.black87,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvailableRewards() {
    return FutureBuilder<List<Reward>>(
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
              userPoints: _userPoints,
              maxRedemptions: reward.maxRedemptions,
              onRedeemSuccess: _refreshAfterRedemption,
            );
          },
        );
      },
    );
  }

  Widget _buildRedeemedRewards() {
    String userId =
        UserProfile.userId.isNotEmpty ? UserProfile.userId : UserProfile.email;

    return FutureBuilder<List<UserRewardRedemption>>(
      future: DatabaseService().getAllRedemptionRecords(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No redemption records found'));
        }

        final allRedemptions = snapshot.data!;

        // Filter redemptions for current user
        final userRedemptions =
            allRedemptions.where((redemption) {
              return redemption.userId == userId;
            }).toList();

        if (userRedemptions.isEmpty) {
          return const Center(child: Text('No redeemed rewards yet'));
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: userRedemptions.length,
          itemBuilder: (context, index) {
            final redemption = userRedemptions[index];
            return RedeemedRewardCard(redemption: redemption);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E5),
      appBar: buildAppBar(context, l10n.myRewards),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                onRefresh: _loadUserPoints,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      RewardsPointsCard(points: _userPoints),
                      _buildToggleButtons(),
                      _showAvailableRewards
                          ? _buildAvailableRewards()
                          : _buildRedeemedRewards(),
                      const HowItWorksSection(),
                      const FAQContainer(),
                    ],
                  ),
                ),
              ),
    );
  }
}

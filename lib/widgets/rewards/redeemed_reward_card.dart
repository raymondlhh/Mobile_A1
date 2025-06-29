import 'package:flutter/material.dart';
import '../../models/user_reward_redemption.dart';
import '../../services/database_service.dart';

class RedeemedRewardCard extends StatefulWidget {
  final UserRewardRedemption redemption;

  const RedeemedRewardCard({super.key, required this.redemption});

  @override
  State<RedeemedRewardCard> createState() => _RedeemedRewardCardState();
}

class _RedeemedRewardCardState extends State<RedeemedRewardCard> {
  String? _rewardImagePath;
  bool _isLoadingImage = true;

  @override
  void initState() {
    super.initState();
    _loadRewardImage();
  }

  Future<void> _loadRewardImage() async {
    try {
      final databaseService = DatabaseService();
      final rewards = await databaseService.getAvailableRewards();

      // Find the reward that matches the redemption
      final reward = rewards.firstWhere(
        (r) => r.id == widget.redemption.rewardId,
        orElse: () => rewards.first, // Fallback to first reward if not found
      );

      if (mounted) {
        setState(() {
          _rewardImagePath = reward.imagePath;
          _isLoadingImage = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingImage = false;
        });
      }
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          color: const Color(0xFFE8F5E8), // Light green background for redeemed
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
                  color: const Color(0xFF4CAF50), // Green border for redeemed
                  width: 10,
                ),
              ),
              child:
                  _isLoadingImage
                      ? const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF4CAF50),
                        ),
                      )
                      : _rewardImagePath != null
                      ? ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.asset(
                          _rewardImagePath!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.check_circle,
                              size: 60,
                              color: Color(0xFF4CAF50),
                            );
                          },
                        ),
                      )
                      : const Icon(
                        Icons.check_circle,
                        size: 60,
                        color: Color(0xFF4CAF50),
                      ),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'REDEEMED',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.redemption.rewardName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              '${widget.redemption.pointsSpent} pts spent',
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Redeemed on ${_formatDate(widget.redemption.redeemedAt)}',
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 9,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../screens/rewards/reward_detail_page.dart';
import '../../services/database_service.dart';
import '../../models/user_profile.dart';

class RewardCard extends StatefulWidget {
  final String id;
  final String imagePath;
  final String itemName;
  final String description;
  final int points;
  final int validity;
  final int userPoints;
  final int maxRedemptions;
  final VoidCallback? onRedeemSuccess;

  const RewardCard({
    super.key,
    required this.id,
    required this.imagePath,
    required this.itemName,
    required this.description,
    required this.points,
    required this.validity,
    required this.userPoints,
    required this.maxRedemptions,
    this.onRedeemSuccess,
  });

  @override
  State<RewardCard> createState() => _RewardCardState();
}

class _RewardCardState extends State<RewardCard> {
  int _userRedemptionCount = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserRedemptionCount();
  }

  @override
  void didUpdateWidget(RewardCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Refresh redemption count when widget is updated (e.g., after redemption)
    if (oldWidget.userPoints != widget.userPoints) {
      _loadUserRedemptionCount();
    }
  }

  Future<void> _loadUserRedemptionCount() async {
    try {
      final databaseService = DatabaseService();
      String userId =
          UserProfile.userId.isNotEmpty
              ? UserProfile.userId
              : UserProfile.email;
      final count = await databaseService.getUserRewardRedemptionCount(
        userId,
        widget.id,
      );
      if (mounted) {
        setState(() {
          _userRedemptionCount = count;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  bool get canAfford => widget.userPoints >= widget.points;
  bool get canRedeem => _userRedemptionCount < widget.maxRedemptions;
  bool get isFullyRedeemed => !canRedeem;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => RedeemPage(
                  id: widget.id,
                  imagePath: widget.imagePath,
                  itemName: widget.itemName,
                  description: widget.description,
                  points: widget.points,
                  validity: widget.validity,
                  userPoints: widget.userPoints,
                  maxRedemptions: widget.maxRedemptions,
                  userRedemptionCount: _userRedemptionCount,
                  onRedeemSuccess: widget.onRedeemSuccess,
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
            color:
                !isFullyRedeemed
                    ? const Color(0xFF8AB98F)
                    : Colors.grey.shade400,
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
                    color:
                        !isFullyRedeemed
                            ? const Color(0xFFCA3202)
                            : Colors.grey.shade600,
                    width: 10,
                  ),
                ),
                child: Image.asset(
                  widget.imagePath,
                  fit: BoxFit.cover,
                  color: !isFullyRedeemed ? null : Colors.grey.shade400,
                  colorBlendMode:
                      !isFullyRedeemed ? null : BlendMode.saturation,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: !isFullyRedeemed ? Colors.white : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color:
                        !isFullyRedeemed
                            ? const Color(0xFF7F7F7F)
                            : Colors.grey.shade400,
                    width: 1,
                  ),
                ),
                child: Text(
                  '${widget.points} ${l10n.points}',
                  style: TextStyle(
                    color:
                        !isFullyRedeemed ? Colors.black : Colors.grey.shade600,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                widget.itemName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: !isFullyRedeemed ? Colors.black : Colors.grey.shade600,
                  fontSize: 13,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (!_isLoading) ...[
                const SizedBox(height: 4),
                Text(
                  '${_userRedemptionCount}/${widget.maxRedemptions} ${l10n.redeemed}',
                  style: TextStyle(
                    color:
                        !isFullyRedeemed
                            ? Colors.black87
                            : Colors.grey.shade600,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
              if (!canAfford && !isFullyRedeemed) ...[
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    l10n.insufficientPoints,
                    style: TextStyle(
                      color: Colors.red.shade800,
                      fontSize: 8,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

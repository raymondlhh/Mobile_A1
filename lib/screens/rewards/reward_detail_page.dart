import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../widgets/title_appbar.dart';
import '../../services/database_service.dart';
import '../../models/user_profile.dart';

class RedeemPage extends StatelessWidget {
  final String id;
  final String imagePath;
  final String itemName;
  final String description;
  final int points;
  final int validity;
  final int userPoints;
  final int maxRedemptions;
  final int userRedemptionCount;
  final VoidCallback? onRedeemSuccess;

  const RedeemPage({
    super.key,
    required this.id,
    required this.imagePath,
    required this.itemName,
    required this.description,
    required this.points,
    required this.validity,
    required this.userPoints,
    required this.maxRedemptions,
    required this.userRedemptionCount,
    this.onRedeemSuccess,
  });

  bool get canAfford => userPoints >= points;
  bool get canRedeem => userRedemptionCount < maxRedemptions;
  bool get canProceed => canAfford && canRedeem;

  Future<void> _handleRedeem(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    if (!canAfford) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            l10n.insufficientPointsToRedeem(points - userPoints),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (!canRedeem) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            l10n.redemptionLimitReached(maxRedemptions),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      final databaseService = DatabaseService();

      // Use user ID if available, otherwise fall back to email
      if (UserProfile.userId.isNotEmpty) {
        await databaseService.redeemRewardWithPointsById(
          id,
          UserProfile.userId,
        );
      } else {
        await databaseService.redeemRewardWithPoints(id, UserProfile.email);
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.rewardRedeemedSuccess),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }

      // Call the callback to refresh the parent screen
      onRedeemSuccess?.call();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.errorRedeemingReward(e.toString())),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  String _getButtonText(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (!canAfford) {
      return l10n.insufficientPoints;
    } else if (!canRedeem) {
      return l10n.redemptionLimitReachedLabel;
    } else {
      return l10n.redeem;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F3E7),
      appBar: buildAppBar(context, l10n.myRewards),
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
                  Text(
                    l10n.pointsRequired,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('${points}${l10n.points}'),
                  const SizedBox(height: 8),
                  Text(
                    l10n.yourCurrentPoints,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${userPoints}${l10n.points}',
                    style: TextStyle(
                      color: canAfford ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (!canAfford) ...[
                    const SizedBox(height: 4),
                    Text(
                      l10n.insufficientPointsToRedeem(points - userPoints),
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ],
                  const SizedBox(height: 8),
                  Text(
                    l10n.yourRedemptionStatus,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${userRedemptionCount}/${maxRedemptions} ${l10n.redeemed}',
                    style: TextStyle(
                      color: canRedeem ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (!canRedeem) ...[
                    const SizedBox(height: 4),
                    Text(
                      l10n.redemptionLimitReachedLabel,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ],
                  const SizedBox(height: 8),
                  Text(
                    l10n.validityPerMonth,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('$validity'),
                  const SizedBox(height: 12),
                  Text(
                    l10n.termsAndConditions,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(l10n.rewardTerms1),
                  Text(l10n.rewardTerms2),
                  Text(l10n.rewardTerms3),
                  Text(l10n.rewardTerms4),
                  Text(l10n.rewardTerms5),
                  Text(l10n.rewardTerms6),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: canProceed ? () => _handleRedeem(context) : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD24545),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  _getButtonText(context),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

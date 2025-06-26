class UserRewardRedemption {
  final String id;
  final String userId;
  final String rewardId;
  final String rewardName;
  final int pointsSpent;
  final DateTime redeemedAt;
  final int
  redemptionCount; // How many times this user has redeemed this reward

  UserRewardRedemption({
    required this.id,
    required this.userId,
    required this.rewardId,
    required this.rewardName,
    required this.pointsSpent,
    required this.redeemedAt,
    required this.redemptionCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'rewardId': rewardId,
      'rewardName': rewardName,
      'pointsSpent': pointsSpent,
      'redeemedAt': redeemedAt.toIso8601String(),
      'redemptionCount': redemptionCount,
    };
  }

  factory UserRewardRedemption.fromMap(String id, Map<String, dynamic> map) {
    return UserRewardRedemption(
      id: id,
      userId: map['userId'] ?? '',
      rewardId: map['rewardId'] ?? '',
      rewardName: map['rewardName'] ?? '',
      pointsSpent: map['pointsSpent'] ?? 0,
      redeemedAt:
          map['redeemedAt'] != null
              ? DateTime.parse(map['redeemedAt'])
              : DateTime.now(),
      redemptionCount: map['redemptionCount'] ?? 1,
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/reward.dart';
import '../models/user_reward_redemption.dart';
import '../models/users.dart';
import '../models/order.dart' as app_models;
import '../models/cart_item.dart';
import '../models/user_profile.dart';
import 'rewards_service.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RewardsService _rewardsService = RewardsService();

  //Collection reference
  final CollectionReference _rewardsCollection = FirebaseFirestore.instance
      .collection('rewards');

  //Orders collection reference
  final CollectionReference _ordersCollection = FirebaseFirestore.instance
      .collection('orders');

  //User reward redemptions collection reference
  final CollectionReference _userRewardRedemptionsCollection = FirebaseFirestore
      .instance
      .collection('userRewardRedemptions');

  //Initialize current rewards
  Future<void> initializeCurrentRewards() async {
    try {
      //Check if rewards already exist
      QuerySnapshot existingRewards = await _rewardsCollection.get();
      if (existingRewards.docs.isNotEmpty) {
        return;
      }

      //Current rewards data
      final List<Map<String, dynamic>> currentRewards = [
        {
          'name': 'Chuka Wakame',
          'description': 'Seaweed salad with a subtly sweet and savory flavor.',
          'points': 1500,
          'imagePath': 'assets/images/foods/appetizers/chuka_wakame.png',
          'validity': 8,
          'maxRedemptions': 3, // User can redeem this 3 times
        },
        {
          'name': 'Ebi Curry Udon',
          'description': 'Curry udon with ebi tempura.',
          'points': 2000,
          'imagePath': 'assets/images/foods/curry_sets/ebi_curry_udon.png',
          'validity': 6,
          'maxRedemptions': 2, // User can redeem this 2 times
        },
        {
          'name': 'Chicken Teriyaki Ramen',
          'description': 'Ramen with chicken teriyaki and vegetables.',
          'points': 1800,
          'imagePath': 'assets/images/foods/ramen/chicken_teriyaki_ramen.png',
          'validity': 7,
          'maxRedemptions': 4, // User can redeem this 4 times
        },
        {
          'name': 'Ebi Tempura',
          'description': 'Crispy battered shrimp tempura.',
          'points': 1700,
          'imagePath': 'assets/images/foods/tempura/ebi_tempura.png',
          'validity': 5,
          'maxRedemptions': 2, // User can redeem this 2 times
        },
      ];

      //Add rewards to Firestore
      for (var rewardData in currentRewards) {
        await _rewardsCollection.add(rewardData);
      }
    } catch (e) {
      rethrow;
    }
  }

  //Reward CRUD operations
  Future<void> addReward(Reward reward) async {
    try {
      await _rewardsCollection.add(reward.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Reward>> getRewards() async {
    try {
      QuerySnapshot snapshot = await _rewardsCollection.get();
      return snapshot.docs.map((doc) {
        return Reward.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> redeemReward(String rewardId) async {
    try {
      await _rewardsCollection.doc(rewardId).update({
        'isRedeemed': true,
        'redeemedAt': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      rethrow;
    }
  }

  //Get user's redemption count for a specific reward
  Future<int> getUserRewardRedemptionCount(
    String userId,
    String rewardId,
  ) async {
    try {
      final QuerySnapshot snapshot =
          await _userRewardRedemptionsCollection
              .where('userId', isEqualTo: userId)
              .where('rewardId', isEqualTo: rewardId)
              .get();

      return snapshot.docs.length;
    } catch (e) {
      return 0;
    }
  }

  //Redeem reward with points deduction
  Future<bool> redeemRewardWithPoints(String rewardId, String userId) async {
    try {
      //Get reward details
      final rewardDoc = await _rewardsCollection.doc(rewardId).get();
      if (!rewardDoc.exists) {
        throw Exception('Reward not found');
      }

      final rewardData = rewardDoc.data() as Map<String, dynamic>;
      final rewardPoints = rewardData['points'] ?? 0;
      final rewardName = rewardData['name'] ?? '';
      final maxRedemptions = rewardData['maxRedemptions'] ?? 1;

      //Check if user has enough points
      final currentPoints = await _rewardsService.getUserRewardsPoints(userId);
      if (currentPoints < rewardPoints) {
        throw Exception('Insufficient rewards points');
      }

      //Check if user has reached their redemption limit for this reward
      final userRedemptionCount = await getUserRewardRedemptionCount(
        userId,
        rewardId,
      );
      if (userRedemptionCount >= maxRedemptions) {
        throw Exception(
          'You have reached the maximum redemption limit for this reward',
        );
      }

      //Deduct points from user account
      await _rewardsService.deductRewardsPoints(userId, rewardPoints);

      //Record user reward redemption
      final redemptionData = {
        'userId': userId,
        'rewardId': rewardId,
        'rewardName': rewardName,
        'pointsSpent': rewardPoints,
        'redeemedAt': DateTime.now().toIso8601String(),
      };

      await _userRewardRedemptionsCollection.add(redemptionData);

      return true;
    } catch (e) {
      rethrow;
    }
  }

  //Get user's reward redemption history
  Future<List<UserRewardRedemption>> getUserRewardHistory(String userId) async {
    try {
      final QuerySnapshot snapshot =
          await _userRewardRedemptionsCollection
              .where('userId', isEqualTo: userId)
              .orderBy('redeemedAt', descending: true)
              .get();

      return snapshot.docs.map((doc) {
        return UserRewardRedemption.fromMap(
          doc.id,
          doc.data() as Map<String, dynamic>,
        );
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Reward>> getAvailableRewards() async {
    try {
      QuerySnapshot snapshot = await _rewardsCollection.get();
      final rewards =
          snapshot.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return Reward.fromMap(doc.id, data);
          }).toList();

      return rewards;
    } catch (e) {
      rethrow;
    }
  }

  //Get available rewards for a specific user (considering user's redemption limits)
  Future<List<Reward>> getAvailableRewardsForUser(String userId) async {
    try {
      QuerySnapshot snapshot = await _rewardsCollection.get();
      final List<Reward> availableRewards = [];

      for (var doc in snapshot.docs) {
        final rewardData = doc.data() as Map<String, dynamic>;
        final maxRedemptions = rewardData['maxRedemptions'] ?? 1;

        //Check if user hasn't reached their personal limit
        final userRedemptionCount = await getUserRewardRedemptionCount(
          userId,
          doc.id,
        );
        if (userRedemptionCount < maxRedemptions) {
          availableRewards.add(Reward.fromMap(doc.id, rewardData));
        }
      }

      return availableRewards;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Reward>> getRedeemedRewards() async {
    try {
      return [];
    } catch (e) {
      rethrow;
    }
  }

  //Get user's redeemed rewards
  Future<List<UserRewardRedemption>> getUserRedeemedRewards(
    String userId,
  ) async {
    try {
      final QuerySnapshot snapshot =
          await _userRewardRedemptionsCollection
              .where('userId', isEqualTo: userId)
              .orderBy('redeemedAt', descending: true)
              .get();

      return snapshot.docs.map((doc) {
        return UserRewardRedemption.fromMap(
          doc.id,
          doc.data() as Map<String, dynamic>,
        );
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteReward(String rewardId) async {
    try {
      await _rewardsCollection.doc(rewardId).delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateReward(String rewardId, Reward reward) async {
    try {
      await _rewardsCollection.doc(rewardId).update(reward.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addOrder(app_models.Order order) async {
    try {
      await _ordersCollection.add(order.toMap());

      //Add points to user for completing an order
      //You can customize the points calculation based on order value
      final orderValue = order.total;
      int pointsToAdd = (orderValue * 10).round(); // 1 point per $10 spent
      if (pointsToAdd < 1) pointsToAdd = 1; // Minimum 1 point per order

      //Add points using user ID
      if (UserProfile.userId.isNotEmpty &&
          UserProfile.email == order.userEmail) {
        await _rewardsService.addRewardsPoints(UserProfile.userId, pointsToAdd);
      }
    } catch (e) {
      rethrow;
    }
  }

  //Get all redemption records
  Future<List<UserRewardRedemption>> getAllRedemptionRecords() async {
    try {
      final QuerySnapshot snapshot =
          await _userRewardRedemptionsCollection
              .orderBy('redeemedAt', descending: true)
              .get();

      return snapshot.docs.map((doc) {
        return UserRewardRedemption.fromMap(
          doc.id,
          doc.data() as Map<String, dynamic>,
        );
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  //Get current user from database
  Future<Users?> getCurrentUser() async {
    try {
      final email = UserProfile.email;
      if (email.isEmpty) {
        return null;
      }

      final QuerySnapshot result =
          await _firestore
              .collection('users')
              .where('email', isEqualTo: email)
              .limit(1)
              .get();

      if (result.docs.isNotEmpty) {
        final userData = result.docs.first.data() as Map<String, dynamic>;
        return Users.fromMap(result.docs.first.id, userData);
      }

      return null;
    } catch (e) {
      rethrow;
    }
  }
}

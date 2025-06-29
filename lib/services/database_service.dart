// ignore_for_file: unused_field, avoid_print

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

  // Collection reference
  final CollectionReference _rewardsCollection = FirebaseFirestore.instance
      .collection('rewards');

  // Orders collection reference
  final CollectionReference _ordersCollection = FirebaseFirestore.instance
      .collection('orders');

  // User reward redemptions collection reference
  final CollectionReference _userRewardRedemptionsCollection = FirebaseFirestore
      .instance
      .collection('userRewardRedemptions');

  // Initialize current rewards
  Future<void> initializeCurrentRewards() async {
    try {
      // Check if rewards already exist
      QuerySnapshot existingRewards = await _rewardsCollection.get();
      if (existingRewards.docs.isNotEmpty) {
        print('Rewards already exist in the database');
        return;
      }

      // Current rewards data
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

      // Add rewards to Firestore
      for (var rewardData in currentRewards) {
        await _rewardsCollection.add(rewardData);
      }
      print('Current rewards added successfully');
    } catch (e) {
      print('Error initializing current rewards: $e');
      rethrow;
    }
  }

  // Reward CRUD operations
  Future<void> addReward(Reward reward) async {
    try {
      await _rewardsCollection.add(reward.toMap());
    } catch (e) {
      print('Error adding reward: $e');
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
      print('Error getting rewards: $e');
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
      print('Error redeeming reward: $e');
      rethrow;
    }
  }

  // Get user's redemption count for a specific reward
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

      // Simply count the number of documents (each document represents one redemption)
      return snapshot.docs.length;
    } catch (e) {
      print('Error getting user reward redemption count: $e');
      return 0;
    }
  }

  // Redeem reward with points deduction by user ID
  Future<bool> redeemRewardWithPointsById(
    String rewardId,
    String userId,
  ) async {
    try {
      // Get reward details
      final rewardDoc = await _rewardsCollection.doc(rewardId).get();
      if (!rewardDoc.exists) {
        throw Exception('Reward not found');
      }

      final rewardData = rewardDoc.data() as Map<String, dynamic>;
      final rewardPoints = rewardData['points'] ?? 0;
      final rewardName = rewardData['name'] ?? '';
      final maxRedemptions = rewardData['maxRedemptions'] ?? 1;

      // Check if user has enough points
      final currentPoints = await _rewardsService.getUserRewardsPointsById(
        userId,
      );
      if (currentPoints < rewardPoints) {
        throw Exception('Insufficient rewards points');
      }

      // Check if user has reached their redemption limit for this reward
      final userRedemptionCount = await getUserRewardRedemptionCount(
        userId,
        rewardId,
      );
      if (userRedemptionCount >= maxRedemptions) {
        throw Exception(
          'You have reached the maximum redemption limit for this reward',
        );
      }

      // Deduct points from user account
      await _rewardsService.deductRewardsPointsById(userId, rewardPoints);

      // Record user reward redemption
      final redemptionData = {
        'userId': userId,
        'rewardId': rewardId,
        'rewardName': rewardName,
        'pointsSpent': rewardPoints,
        'redeemedAt': DateTime.now().toIso8601String(),
      };

      print('DEBUG: Saving redemption data: $redemptionData');
      await _userRewardRedemptionsCollection.add(redemptionData);
      print('DEBUG: Redemption data saved successfully');

      return true;
    } catch (e) {
      print('Error redeeming reward with points: $e');
      rethrow;
    }
  }

  // Redeem reward with points deduction by email (for backward compatibility)
  Future<bool> redeemRewardWithPoints(String rewardId, String userEmail) async {
    try {
      // Get reward details
      final rewardDoc = await _rewardsCollection.doc(rewardId).get();
      if (!rewardDoc.exists) {
        throw Exception('Reward not found');
      }

      final rewardData = rewardDoc.data() as Map<String, dynamic>;
      final rewardPoints = rewardData['points'] ?? 0;
      final rewardName = rewardData['name'] ?? '';
      final maxRedemptions = rewardData['maxRedemptions'] ?? 1;

      // Check if user has enough points
      final currentPoints = await _rewardsService.getUserRewardsPoints(
        userEmail,
      );
      if (currentPoints < rewardPoints) {
        throw Exception('Insufficient rewards points');
      }

      // Check if user has reached their redemption limit for this reward
      final userRedemptionCount = await getUserRewardRedemptionCount(
        userEmail,
        rewardId,
      );
      if (userRedemptionCount >= maxRedemptions) {
        throw Exception(
          'You have reached the maximum redemption limit for this reward',
        );
      }

      // Deduct points from user account
      await _rewardsService.deductRewardsPoints(userEmail, rewardPoints);

      // Record user reward redemption
      final redemptionData = {
        'userId': userEmail,
        'rewardId': rewardId,
        'rewardName': rewardName,
        'pointsSpent': rewardPoints,
        'redeemedAt': DateTime.now().toIso8601String(),
      };

      print('DEBUG: Saving redemption data (email): $redemptionData');
      await _userRewardRedemptionsCollection.add(redemptionData);
      print('DEBUG: Redemption data saved successfully (email)');

      return true;
    } catch (e) {
      print('Error redeeming reward with points: $e');
      rethrow;
    }
  }

  // Get user's reward redemption history by user ID
  Future<List<UserRewardRedemption>> getUserRewardHistoryById(
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
      print('Error getting user reward history: $e');
      return [];
    }
  }

  // Get user's reward redemption history by email (for backward compatibility)
  Future<List<UserRewardRedemption>> getUserRewardHistory(
    String userEmail,
  ) async {
    try {
      final QuerySnapshot snapshot =
          await _userRewardRedemptionsCollection
              .where('userId', isEqualTo: userEmail)
              .orderBy('redeemedAt', descending: true)
              .get();

      return snapshot.docs.map((doc) {
        return UserRewardRedemption.fromMap(
          doc.id,
          doc.data() as Map<String, dynamic>,
        );
      }).toList();
    } catch (e) {
      print('Error getting user reward history: $e');
      return [];
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
      print('Error getting available rewards: $e');
      rethrow;
    }
  }

  // Get available rewards for a specific user (considering user's redemption limits)
  Future<List<Reward>> getAvailableRewardsForUser(String userId) async {
    try {
      QuerySnapshot snapshot = await _rewardsCollection.get();
      final List<Reward> availableRewards = [];

      for (var doc in snapshot.docs) {
        final rewardData = doc.data() as Map<String, dynamic>;
        final maxRedemptions = rewardData['maxRedemptions'] ?? 1;

        // Check if user hasn't reached their personal limit
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
      print('Error getting available rewards for user: $e');
      rethrow;
    }
  }

  Future<List<Reward>> getRedeemedRewards() async {
    try {
      // Since there's no total availability limit, this method now returns an empty list
      // as all rewards are always available (only limited per user)
      return [];
    } catch (e) {
      print('Error getting redeemed rewards: $e');
      rethrow;
    }
  }

  // Get user's redeemed rewards
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
      print('Error getting user redeemed rewards: $e');
      return [];
    }
  }

  Future<void> deleteReward(String rewardId) async {
    try {
      await _rewardsCollection.doc(rewardId).delete();
    } catch (e) {
      print('Error deleting reward: $e');
      rethrow;
    }
  }

  Future<void> updateReward(String rewardId, Reward reward) async {
    try {
      await _rewardsCollection.doc(rewardId).update(reward.toMap());
    } catch (e) {
      print('Error updating reward: $e');
      rethrow;
    }
  }

  Future<void> addOrder(app_models.Order order) async {
    try {
      await _ordersCollection.add(order.toMap());

      // Add points to user for completing an order
      // You can customize the points calculation based on order value
      final orderValue = order.total;
      int pointsToAdd = (orderValue * 10).round(); // 1 point per $10 spent
      if (pointsToAdd < 1) pointsToAdd = 1; // Minimum 1 point per order

      // Try to add points using user ID first, then fall back to email
      bool pointsAdded = false;
      if (UserProfile.userId.isNotEmpty &&
          UserProfile.email == order.userEmail) {
        pointsAdded = await _rewardsService.addRewardsPointsById(
          UserProfile.userId,
          pointsToAdd,
        );
      }

      if (!pointsAdded) {
        await _rewardsService.addRewardsPoints(order.userEmail, pointsToAdd);
      }
    } catch (e) {
      print('Error adding order: $e');
      rethrow;
    }
  }

  // Get user's current rewards points
  Future<int> getUserRewardsPoints(String userEmail) async {
    return await _rewardsService.getUserRewardsPoints(userEmail);
  }

  // Add points to user (for admin/testing purposes)
  Future<bool> addPointsToUser(String userEmail, int points) async {
    return await _rewardsService.addRewardsPoints(userEmail, points);
  }

  // Force re-initialize rewards (for development/testing)
  Future<void> forceReinitializeRewards() async {
    try {
      // Delete all existing rewards
      QuerySnapshot existingRewards = await _rewardsCollection.get();
      for (var doc in existingRewards.docs) {
        await _rewardsCollection.doc(doc.id).delete();
      }
      print('Deleted existing rewards');

      // Re-initialize with new data
      await initializeCurrentRewards();
      print('Re-initialized rewards successfully');
    } catch (e) {
      print('Error re-initializing rewards: $e');
      rethrow;
    }
  }

  // Check current rewards in database (for debugging)
  Future<void> checkCurrentRewards() async {
    try {
      QuerySnapshot snapshot = await _rewardsCollection.get();
      print('=== Current Rewards in Database ===');
      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        print('Reward ID: ${doc.id}');
        print('  Name: ${data['name']}');
        print('  Points: ${data['points']}');
        print('  maxRedemptions: ${data['maxRedemptions']}');
        print('  All fields: $data');
        print('---');
      }
    } catch (e) {
      print('Error checking current rewards: $e');
    }
  }

  // Update existing rewards to include maxRedemptions field
  Future<void> updateExistingRewardsWithMaxRedemptions() async {
    try {
      QuerySnapshot snapshot = await _rewardsCollection.get();
      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        if (!data.containsKey('maxRedemptions')) {
          // Set default maxRedemptions based on reward name
          int maxRedemptions = 1; // default
          String name = data['name'] ?? '';
          if (name.contains('Chuka Wakame')) {
            maxRedemptions = 3;
          } else if (name.contains('Ebi Curry Udon')) {
            maxRedemptions = 2;
          } else if (name.contains('Chicken Teriyaki Ramen')) {
            maxRedemptions = 4;
          } else if (name.contains('Ebi Tempura')) {
            maxRedemptions = 2;
          }

          await _rewardsCollection.doc(doc.id).update({
            'maxRedemptions': maxRedemptions,
          });
          print('Updated ${name} with maxRedemptions: $maxRedemptions');
        }
      }
    } catch (e) {
      print('Error updating existing rewards: $e');
    }
  }

  // Test method to add sample redemption data (for testing purposes)
  Future<void> addTestRedemptionData(String userId) async {
    try {
      print('DEBUG: Adding test redemption data for user: $userId');

      final testRedemptionData = {
        'userId': userId,
        'rewardId': 'test_reward_1',
        'rewardName': 'Chuka Wakame',
        'pointsSpent': 1500,
        'redeemedAt':
            DateTime.now().subtract(const Duration(days: 2)).toIso8601String(),
      };

      await _userRewardRedemptionsCollection.add(testRedemptionData);
      print('DEBUG: Test redemption data added successfully');

      // Add another test redemption
      final testRedemptionData2 = {
        'userId': userId,
        'rewardId': 'test_reward_2',
        'rewardName': 'Ebi Curry Udon',
        'pointsSpent': 2000,
        'redeemedAt':
            DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
      };

      await _userRewardRedemptionsCollection.add(testRedemptionData2);
      print('DEBUG: Second test redemption data added successfully');
    } catch (e) {
      print('Error adding test redemption data: $e');
    }
  }

  // Clear existing redemption data (for testing/fixing data structure)
  Future<void> clearExistingRedemptions() async {
    try {
      QuerySnapshot existingRedemptions =
          await _userRewardRedemptionsCollection.get();
      for (var doc in existingRedemptions.docs) {
        await _userRewardRedemptionsCollection.doc(doc.id).delete();
      }
      print('Cleared existing redemption data');
    } catch (e) {
      print('Error clearing redemption data: $e');
    }
  }

  // Clear old userRewards collection data (since we're now using userRewardRedemptions)
  Future<void> clearOldUserRewardsData() async {
    try {
      final oldCollection = FirebaseFirestore.instance.collection(
        'userRewards',
      );
      QuerySnapshot existingData = await oldCollection.get();
      for (var doc in existingData.docs) {
        await oldCollection.doc(doc.id).delete();
      }
      print('Cleared old userRewards collection data');
    } catch (e) {
      print('Error clearing old userRewards data: $e');
    }
  }

  // Get all redemption records (for debugging purposes)
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
      print('Error getting all redemption records: $e');
      return [];
    }
  }

  // Get current user from database
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
      print('Error getting current user: $e');
      return null;
    }
  }
}

// ignore_for_file: unused_field, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/reward.dart';
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

  // User rewards collection reference
  final CollectionReference _userRewardsCollection = FirebaseFirestore.instance
      .collection('userRewards');

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
          'isRedeemed': false,
          'validity': 8,
        },
        {
          'name': 'Ebi Curry Udon',
          'description': 'Curry udon with ebi tempura.',
          'points': 2000,
          'imagePath': 'assets/images/foods/curry_sets/ebi_curry_udon.png',
          'isRedeemed': false,
          'validity': 6,
        },
        {
          'name': 'Chicken Teriyaki Ramen',
          'description': 'Ramen with chicken teriyaki and vegetables.',
          'points': 1800,
          'imagePath': 'assets/images/foods/ramen/chicken_teriyaki_ramen.png',
          'isRedeemed': false,
          'validity': 7,
        },
        {
          'name': 'Ebi Tempura',
          'description': 'Crispy battered shrimp tempura.',
          'points': 1700,
          'imagePath': 'assets/images/foods/tempura/ebi_tempura.png',
          'isRedeemed': false,
          'validity': 5,
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

      // Check if user has enough points
      final currentPoints = await _rewardsService.getUserRewardsPointsById(
        userId,
      );
      if (currentPoints < rewardPoints) {
        throw Exception('Insufficient rewards points');
      }

      // Deduct points from user account
      await _rewardsService.deductRewardsPointsById(userId, rewardPoints);

      // Mark reward as redeemed
      await _rewardsCollection.doc(rewardId).update({
        'isRedeemed': true,
        'redeemedAt': DateTime.now().toIso8601String(),
        'redeemedBy': userId,
      });

      // Record user reward redemption
      await _userRewardsCollection.add({
        'userId': userId,
        'rewardId': rewardId,
        'rewardName': rewardName,
        'pointsSpent': rewardPoints,
        'redeemedAt': DateTime.now().toIso8601String(),
      });

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

      // Check if user has enough points
      final currentPoints = await _rewardsService.getUserRewardsPoints(
        userEmail,
      );
      if (currentPoints < rewardPoints) {
        throw Exception('Insufficient rewards points');
      }

      // Deduct points from user account
      await _rewardsService.deductRewardsPoints(userEmail, rewardPoints);

      // Mark reward as redeemed
      await _rewardsCollection.doc(rewardId).update({
        'isRedeemed': true,
        'redeemedAt': DateTime.now().toIso8601String(),
        'redeemedBy': userEmail,
      });

      // Record user reward redemption
      await _userRewardsCollection.add({
        'userId': userEmail,
        'rewardId': rewardId,
        'rewardName': rewardName,
        'pointsSpent': rewardPoints,
        'redeemedAt': DateTime.now().toIso8601String(),
      });

      return true;
    } catch (e) {
      print('Error redeeming reward with points: $e');
      rethrow;
    }
  }

  // Get user's reward redemption history by user ID
  Future<List<Map<String, dynamic>>> getUserRewardHistoryById(
    String userId,
  ) async {
    try {
      final QuerySnapshot snapshot =
          await _userRewardsCollection
              .where('userId', isEqualTo: userId)
              .orderBy('redeemedAt', descending: true)
              .get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          'id': doc.id,
          'rewardName': data['rewardName'] ?? '',
          'pointsSpent': data['pointsSpent'] ?? 0,
          'redeemedAt': data['redeemedAt'] ?? '',
        };
      }).toList();
    } catch (e) {
      print('Error getting user reward history: $e');
      return [];
    }
  }

  // Get user's reward redemption history by email (for backward compatibility)
  Future<List<Map<String, dynamic>>> getUserRewardHistory(
    String userEmail,
  ) async {
    try {
      final QuerySnapshot snapshot =
          await _userRewardsCollection
              .where('userId', isEqualTo: userEmail)
              .orderBy('redeemedAt', descending: true)
              .get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          'id': doc.id,
          'rewardName': data['rewardName'] ?? '',
          'pointsSpent': data['pointsSpent'] ?? 0,
          'redeemedAt': data['redeemedAt'] ?? '',
        };
      }).toList();
    } catch (e) {
      print('Error getting user reward history: $e');
      return [];
    }
  }

  Future<List<Reward>> getAvailableRewards() async {
    try {
      QuerySnapshot snapshot =
          await _rewardsCollection.where('isRedeemed', isEqualTo: false).get();
      return snapshot.docs.map((doc) {
        return Reward.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Error getting available rewards: $e');
      rethrow;
    }
  }

  Future<List<Reward>> getRedeemedRewards() async {
    try {
      QuerySnapshot snapshot =
          await _rewardsCollection.where('isRedeemed', isEqualTo: true).get();
      return snapshot.docs.map((doc) {
        return Reward.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Error getting redeemed rewards: $e');
      rethrow;
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
      int pointsToAdd = (orderValue / 10).round(); // 1 point per $10 spent
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
}

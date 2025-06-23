// ignore_for_file: unused_field, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/reward.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collection reference
  final CollectionReference _rewardsCollection = FirebaseFirestore.instance
      .collection('rewards');

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
}

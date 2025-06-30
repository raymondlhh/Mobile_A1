import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_profile.dart';

class RewardsService {
  static final RewardsService _instance = RewardsService._internal();
  factory RewardsService() => _instance;
  RewardsService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _usersCollection = FirebaseFirestore.instance
      .collection('users');

  //Get user's current rewards points by user ID
  Future<int> getUserRewardsPoints(String userId) async {
    try {
      final QuerySnapshot result =
          await _usersCollection
              .where('userId', isEqualTo: userId)
              .limit(1)
              .get();

      if (result.docs.isNotEmpty) {
        final userData = result.docs.first.data() as Map<String, dynamic>;
        return userData['rewardsPoints'] ?? 0;
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }

  //Add points to user's account by user ID
  Future<bool> addRewardsPoints(String userId, int points) async {
    try {
      final QuerySnapshot result =
          await _usersCollection
              .where('userId', isEqualTo: userId)
              .limit(1)
              .get();

      if (result.docs.isNotEmpty) {
        final docId = result.docs.first.id;
        final userData = result.docs.first.data() as Map<String, dynamic>?;
        final currentPoints = userData?['rewardsPoints'] ?? 0;
        final newPoints = currentPoints + points;

        await _usersCollection.doc(docId).update({'rewardsPoints': newPoints});

        //Update UserProfile if this is the current user
        if (UserProfile.userId == userId) {
          UserProfile.rewardsPoints = newPoints;
        }

        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  //Deduct points from user's account by user ID
  Future<bool> deductRewardsPoints(String userId, int points) async {
    try {
      final QuerySnapshot result =
          await _usersCollection
              .where('userId', isEqualTo: userId)
              .limit(1)
              .get();

      if (result.docs.isNotEmpty) {
        final docId = result.docs.first.id;
        final userData = result.docs.first.data() as Map<String, dynamic>?;
        final currentPoints = userData?['rewardsPoints'] ?? 0;

        if (currentPoints < points) {
          throw Exception('Insufficient rewards points');
        }

        final newPoints = currentPoints - points;

        await _usersCollection.doc(docId).update({'rewardsPoints': newPoints});

        //Update UserProfile if this is the current user
        if (UserProfile.userId == userId) {
          UserProfile.rewardsPoints = newPoints;
        }

        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  //Update user's rewards points by user ID (for admin purposes)
  Future<bool> updateRewardsPoints(String userId, int points) async {
    try {
      final QuerySnapshot result =
          await _usersCollection
              .where('userId', isEqualTo: userId)
              .limit(1)
              .get();

      if (result.docs.isNotEmpty) {
        final docId = result.docs.first.id;

        await _usersCollection.doc(docId).update({'rewardsPoints': points});

        //Update UserProfile if this is the current user
        if (UserProfile.userId == userId) {
          UserProfile.rewardsPoints = points;
        }

        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  //Get current user's rewards points from UserProfile
  int getCurrentUserPoints() {
    return UserProfile.rewardsPoints;
  }

  //Refresh current user's points from database
  Future<void> refreshCurrentUserPoints() async {
    if (UserProfile.userId.isNotEmpty) {
      final points = await getUserRewardsPoints(UserProfile.userId);
      UserProfile.rewardsPoints = points;
    }
  }
}

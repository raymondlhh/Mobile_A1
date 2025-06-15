import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/reward.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collection reference
  final CollectionReference _rewardsCollection = FirebaseFirestore.instance
      .collection('rewards');

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
}

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_profile.dart';

class BalanceService {
  static const String _balanceField = 'balance';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<double> getBalance() async {
    // For testing: hardcode a userId
    // final userId = 'YOUR_TEST_USER_ID'; // Replace with a real userId from Firestore
    final userId = UserProfile.userId;
    print('Getting balance for user: $userId');
    if (userId.isEmpty) return 0.0;
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists && doc.data() != null && doc.data()![_balanceField] != null) {
        print('Balance loaded from Firestore: ${doc.data()![_balanceField]}');
        return (doc.data()![_balanceField] as num).toDouble();
      }
      print('No balance found in Firestore, returning 0.0');
      return 0.0;
    } catch (e) {
      print('Error getting balance: $e');
      return 0.0;
    }
  }

  Future<void> setBalance(double value) async {
    // For testing: hardcode a userId
    // final userId = 'YOUR_TEST_USER_ID'; // Replace with a real userId from Firestore
    final userId = UserProfile.userId;
    print('Setting balance for user: $userId to $value');
    if (userId.isEmpty) return;
    try {
      await _firestore.collection('users').doc(userId).set(
        { _balanceField: value },
        SetOptions(merge: true), // merge so you don't overwrite other fields
      );
      print('Balance set successfully');
    } catch (e) {
      print('Error setting balance: $e');
    }
  }
} 
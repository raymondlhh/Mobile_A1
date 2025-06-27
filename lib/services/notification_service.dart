import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_profile.dart';

class NotificationItem {
  final String type; // e.g., 'topUpSuccess', 'paymentSuccess', 'pointsEarned'
  final Map<String, dynamic> params; // e.g., { 'amount': '100.00' }
  final String name; // legacy, for backward compatibility
  final String description; // legacy, for backward compatibility
  final String date;
  final String time;
  bool isRead;
  final DateTime timestamp;

  NotificationItem({
    required this.type,
    required this.params,
    this.name = '', // legacy
    this.description = '', // legacy
    required this.date,
    required this.time,
    this.isRead = false,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    'type': type,
    'params': params,
    'name': name,
    'description': description,
    'date': date,
    'time': time,
    'isRead': isRead,
    'timestamp': timestamp.toIso8601String(),
  };

  static NotificationItem fromJson(Map<String, dynamic> json) => NotificationItem(
    type: json['type'] ?? '',
    params: json['params'] != null ? Map<String, dynamic>.from(json['params']) : {},
    name: json['name'] ?? '',
    description: json['description'] ?? '',
    date: json['date'],
    time: json['time'],
    isRead: json['isRead'] ?? false,
    timestamp: json['timestamp'] != null ? DateTime.parse(json['timestamp']) : DateTime.now(),
  );
}

class NotificationService extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<NotificationItem>> getNotifications() async {
    final userId = UserProfile.userId;
    if (userId.isEmpty) return [];
    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('notifications')
        .orderBy('timestamp', descending: true)
        .get();
    return snapshot.docs.map((doc) => NotificationItem.fromJson(doc.data())).toList();
  }

  Future<void> saveNotifications(List<NotificationItem> notifications) async {
    final userId = UserProfile.userId;
    if (userId.isEmpty) return;
    final batch = _firestore.batch();
    final collection = _firestore.collection('users').doc(userId).collection('notifications');
    // Clear existing notifications
    final existing = await collection.get();
    for (var doc in existing.docs) {
      batch.delete(doc.reference);
    }
    // Add new notifications
    for (var n in notifications) {
      final docRef = collection.doc();
      batch.set(docRef, n.toJson());
    }
    await batch.commit();
    notifyListeners();
  }

  Future<void> addNotification(NotificationItem notification) async {
    final userId = UserProfile.userId;
    if (userId.isEmpty) return;
    final collection = _firestore.collection('users').doc(userId).collection('notifications');
    await collection.add(notification.toJson());
    notifyListeners();
  }

  Future<void> markAllAsRead() async {
    final userId = UserProfile.userId;
    if (userId.isEmpty) return;
    final collection = _firestore.collection('users').doc(userId).collection('notifications');
    final snapshot = await collection.get();
    final batch = _firestore.batch();
    for (var doc in snapshot.docs) {
      batch.update(doc.reference, {'isRead': true});
    }
    await batch.commit();
    notifyListeners();
  }

  Future<void> clearAllNotifications() async {
    final userId = UserProfile.userId;
    if (userId.isEmpty) return;
    final collection = _firestore.collection('users').doc(userId).collection('notifications');
    final snapshot = await collection.get();
    final batch = _firestore.batch();
    for (var doc in snapshot.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
    notifyListeners();
  }
} 
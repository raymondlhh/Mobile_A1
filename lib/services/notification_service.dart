import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_profile.dart';

class NotificationItem {
  final String name;
  final String description;
  final String date;
  final String time;
  bool isRead;

  NotificationItem({
    required this.name,
    required this.description,
    required this.date,
    required this.time,
    this.isRead = false,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
    'date': date,
    'time': time,
    'isRead': isRead,
  };

  static NotificationItem fromJson(Map<String, dynamic> json) => NotificationItem(
    name: json['name'],
    description: json['description'],
    date: json['date'],
    time: json['time'],
    isRead: json['isRead'] ?? false,
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
        .orderBy('date', descending: true)
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
} 
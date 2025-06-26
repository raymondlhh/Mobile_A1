import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

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

class NotificationService {
  static const String _key = 'notifications';

  Future<List<NotificationItem>> getNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_key) ?? [];
    return data.map((e) => NotificationItem.fromJson(json.decode(e))).toList();
  }

  Future<void> saveNotifications(List<NotificationItem> notifications) async {
    final prefs = await SharedPreferences.getInstance();
    final data = notifications.map((e) => json.encode(e.toJson())).toList();
    await prefs.setStringList(_key, data);
  }

  Future<void> addNotification(NotificationItem notification) async {
    final notifications = await getNotifications();
    notifications.insert(0, notification); // newest first
    await saveNotifications(notifications);
  }

  Future<void> markAllAsRead() async {
    final notifications = await getNotifications();
    for (var n in notifications) {
      n.isRead = true;
    }
    await saveNotifications(notifications);
  }
} 
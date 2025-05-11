import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Color(0xFFFFF8E5),
      ),
      body: const Center(
        child: Text('Notification Screen Content'),
      ),
    );
  }
}

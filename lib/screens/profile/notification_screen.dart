import 'package:flutter/material.dart';
import '../../widgets/title_notification.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Notification', showNotification: false),
      body: const Center(
        child: Text('Notification Screen Content'),
      ),
    );
  }
}

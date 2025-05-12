import 'package:flutter/material.dart';
import '../screens/profile/notification_screen.dart';

VoidCallback? onTickPressed;

enum AppBarActionType {
  none,
  notificationButton,
  saveProfileButton,
}

AppBar buildAppBar(BuildContext context, String title, {AppBarActionType actionType = AppBarActionType.notificationButton}) {
  return AppBar(
    backgroundColor: const Color(0xFFFFF8E5),
    elevation: 0,
    centerTitle: true,
    title: Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'GaMaamli',
          fontSize: 22,
          color: Colors.black,
        ),
      ),
    ),
    actions: _buildAppBarActions(context, actionType),
  );
}

List<Widget>? _buildAppBarActions(BuildContext context, AppBarActionType actionType) {
  switch (actionType) {
    case AppBarActionType.notificationButton:
      return [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: IconButton(
            icon: Image.asset('assets/images/icons/Notification.png', width: 24),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const NotificationScreen()),
              );
            },
          ),
        ),
      ];
    case AppBarActionType.saveProfileButton:
      return [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: IconButton(
            icon: Image.asset('assets/images/icons/Tick.png', width: 24),
            onPressed: () {
              if (onTickPressed != null) {
                onTickPressed!();
              }
            },
          ),
        ),
      ];
    case AppBarActionType.none:
      return null;
  }
}

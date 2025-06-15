import 'package:flutter/material.dart';
import '../screens/profile/notification_screen.dart';
import '../../screens/home/detail_home_screen.dart';



VoidCallback? onTickPressed;
bool _isBookmarked = false;

enum AppBarActionType {
  none,
  notificationButton,
  saveProfileButton,
  saveFavButton,
  readButton,
}

AppBar buildAppBar(BuildContext context, String title, {AppBarActionType actionType = AppBarActionType.notificationButton}) {
  return AppBar(
    backgroundColor: const Color(0xFFFFF8E5),
    elevation: 0,
    centerTitle: true,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.black),
      onPressed: () {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DetailHomeScreen()),
          );
        }
      },
    ),
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
    case AppBarActionType.none:
      return null;
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
    case AppBarActionType.saveFavButton:
    return [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: StatefulBuilder(
            builder: (context, setState) {
              return IconButton(
                icon: Image.asset(
                  _isBookmarked
                      ? 'assets/images/others/BookmarkOn.png'
                      : 'assets/images/others/BookmarkOff.png',
                  width: 24,
                ),
                onPressed: () {
                  setState(() {
                    _isBookmarked = !_isBookmarked;
                  }
                );
              },
            );
          },
        ),
      ),
    ];
    case AppBarActionType.readButton:
    return [
      Padding(
        padding: const EdgeInsets.only(right: 16),
        child: IconButton(
          icon: Image.asset('assets/images/icons/Read.png', width: 24),
          onPressed: () {
            if (onTickPressed != null) {
              onTickPressed!();
            }
          },
        ),
      ),
    ];
  }
}

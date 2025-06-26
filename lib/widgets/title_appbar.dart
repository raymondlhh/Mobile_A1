import 'package:flutter/material.dart';
import '../screens/profile/notification_screen.dart';
import '../screens/home/detail_home_screen.dart';
import '../models/menu_item.dart';
import '../services/favourite_service.dart';
import '../services/notification_service.dart';
import 'package:provider/provider.dart';

VoidCallback? onTickPressed;

enum AppBarActionType {
  none,
  notificationButton,
  saveProfileButton,
  saveFavButton,
  readButton,
}

AppBar buildAppBar(
  BuildContext context,
  String title, {
  AppBarActionType actionType = AppBarActionType.notificationButton,
  MenuItem? menuItem,
  FavouriteService? favouriteService,
}) {
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
    actions: _buildAppBarActions(context, actionType, menuItem, favouriteService),
  );
}

List<Widget>? _buildAppBarActions(
  BuildContext context,
  AppBarActionType actionType,
  MenuItem? menuItem,
  FavouriteService? favouriteService,
) {
  switch (actionType) {
    case AppBarActionType.none:
      return null;
    case AppBarActionType.notificationButton:
      return [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Consumer<NotificationService>(
            builder: (context, notificationService, _) {
              return FutureBuilder<int>(
                future: notificationService.getNotifications().then(
                  (list) => list.where((n) => !n.isRead).length,
                ),
                builder: (context, snapshot) {
                  int unreadCount = snapshot.data ?? 0;
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      IconButton(
                        icon: Image.asset(
                          'assets/images/icons/Notification.png',
                          width: 24,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const NotificationScreen(),
                            ),
                          );
                        },
                      ),
                      if (unreadCount > 0)
                        Positioned(
                          right: 4,
                          top: 4,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Text(
                              '$unreadCount',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  );
                },
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
          child: ListenableBuilder(
            listenable: favouriteService!,
            builder: (context, child) {
              return IconButton(
                icon: Image.asset(
                  favouriteService.isFavourite(menuItem!)
                      ? 'assets/images/others/bookmarkOn.png'
                      : 'assets/images/others/bookmarkOff.png',
                  width: 24,
                ),
                onPressed: () {
                  favouriteService.toggleFavourite(menuItem);
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

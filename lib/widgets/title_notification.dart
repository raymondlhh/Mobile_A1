import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context, String title, {bool showNotification = true}) {
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
    actions: showNotification
    ? [
        Padding(
          padding: const EdgeInsets.only(right: 16, bottom: 0),
          child: IconButton(
            icon: Image.asset('assets/images/icons/Notification.png', width: 24),
            onPressed: () => Navigator.pushNamed(context, '/notification'),
          ),
        ),
      ]
    : null, // If false, no notification button
  );
}

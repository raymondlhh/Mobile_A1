import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'widgets/bottom_nav.dart';
import 'screens/profile/edit_screen.dart';
import 'screens/profile/notification_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFFF8E5),
      ),
      home: const BottomNav(),
      routes: {
        '/edit': (context) => const EditScreen(),
        '/notification': (context) => const NotificationScreen(),
      },
    );
  }
}

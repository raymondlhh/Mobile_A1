import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'widgets/bottom_nav.dart';

void main() {
  // Set status bar icons to black
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
        scaffoldBackgroundColor: Color(0xFFFFF8E5), // 🌕 Set background color here
      ),
      home: BottomNav(),
    );
  }
}



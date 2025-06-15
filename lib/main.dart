import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'widgets/bottom_nav.dart';
//import 'screens/home/home_screen.dart';
import 'screens/home/detail_home_screen.dart';

import 'screens/profile/edit_screen.dart';
import 'screens/profile/notification_screen.dart';
import 'screens/profile/favourite_screen.dart';
import 'screens/profile/balance_screen.dart';
import 'screens/profile/setting_screen.dart';

import 'screens/home/welcome_screen.dart';
import 'screens/home/signup_screen.dart';
import 'screens/home/login_screen.dart';
import 'screens/home/forgot_password_screen.dart';
import 'screens/home/restaurant_menu_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'providers/cart_provider.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (ctx) => CartProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFFFF8E5)),
      initialRoute: '/welcome',
      routes: {
        '/': (context) => const BottomNav(),
        '/welcome': (context) => const WelcomeScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/login': (context) => const LoginScreen(),
        '/forgot': (context) => const ForgotPasswordScreen(),
        '/bottomNav': (context) => const BottomNav(),
        '/home': (context) => const DetailHomeScreen(),
        '/edit': (context) => const EditScreen(),
        '/notification': (context) => const NotificationScreen(),
        '/favourite': (context) => const FavouriteScreen(),
        '/balance': (context) => const BalanceScreen(),
        '/setting': (context) => const SettingScreen(),
        '/restaurant_menu': (context) => const RestaurantMenuScreen(),
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'services/database_service.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'services/rewards_service.dart';
import 'models/user_profile.dart';
import 'services/notification_service.dart';

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
import 'screens/home/video_splash_screen.dart';
import 'screens/menu/checkout_page.dart';

import 'package:firebase_core/firebase_core.dart';
// ignore: unused_import
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Initialize database with rewards
  final databaseService = DatabaseService();
  await databaseService
      .updateExistingRewardsWithMaxRedemptions(); // Update existing rewards with maxRedemptions
  await databaseService.clearExistingRedemptions(); // Clear old redemption data
  await databaseService.checkCurrentRewards(); // Check what's in the database

  // Add some test points to the default user (for demonstration)
  final rewardsService = RewardsService();
  await rewardsService.addRewardsPoints(UserProfile.email, 5000);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => NotificationService()),
      ],
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
        '/videoSplash': (context) => const VideoSplashScreen(),
        '/checkout': (context) => const CheckoutPage(),
      },
    );
  }
}

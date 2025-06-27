import 'package:flutter/material.dart';
import '../../services/favourite_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _loadDataAndNavigate();
  }

  Future<void> _loadDataAndNavigate() async {
    // Load favourites (and any other needed data)
    await FavouriteService().loadFavourites();
    // You can load other data here if needed
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/bottomNav');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFFFF8E5),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
} 
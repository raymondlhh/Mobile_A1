// lib/screens/home/profile_screen.dart
import 'package:flutter/material.dart';
import '../../widgets/title_appbar.dart';
import '../../widgets/profile_picture.dart';

import '../profile/favourite_screen.dart';
import '../profile/balance_screen.dart';
import '../profile/setting_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});  // FIX key constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'MY PROFILE'),
      backgroundColor: const Color(0xFFFFF8E5), // also match screen background
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/images/others/InkPainting.png',
                  width: double.infinity,
                  height: 160,
                  fit: BoxFit.cover,
                ),
                ProfileHeader(showDetails: true),
              ],
            ),
            const SizedBox(height: 30),
            _buildActionButtons(context),
            const SizedBox(height: 60),
            _buildLogoutButton(context),
            const SizedBox(height: 50),
            _buildFooterImage(context),
          ],
        ),
      ),
    );
  }
}

Widget _buildActionButtons(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const FavouriteScreen()),
          );
        },
        child: Image.asset(
          'assets/images/buttons/FavouriteButton.png',
          width: 110,
        ),
      ),
      const SizedBox(width: 12),
      GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const BalanceScreen()),
          );
        },
        child: Image.asset(
          'assets/images/buttons/BalanceButton.png',
          width: 110,
        ),
      ),
      const SizedBox(width: 12),
      GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const SettingScreen()),
          );
        },
        child: Image.asset(
          'assets/images/buttons/SettingButton.png',
          width: 110,
        ),
      ),
    ],
  );
}

Widget _buildLogoutButton(BuildContext context) {
  return GestureDetector(
    onTap: () {

    },
    child: Image.asset(
      'assets/images/buttons/LogOutButton.png',
      width: 160, // adjust size as needed
      height: 50,
      fit: BoxFit.contain,
    ),
  );
}

Widget _buildFooterImage(BuildContext context) {
  return Image.asset(
    'assets/images/others/BottomLogo.png', // Replace with your footer image asset path
    height: 180,
    fit: BoxFit.cover,
  );
}


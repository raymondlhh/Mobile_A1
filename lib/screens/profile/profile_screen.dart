// lib/screens/home/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/title_appbar.dart';
import '../../widgets/profile_description.dart';
import '../../models/user_profile.dart';

import '../profile/favourite_screen.dart';
import '../profile/balance_screen.dart';
import '../profile/setting_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});  // FIX key constructor

  Future<void> _logout(BuildContext context) async {
    // Clear UserProfile data
    UserProfile.userId = '';
    UserProfile.name = '';
    UserProfile.email = '';
    UserProfile.password = '';
    UserProfile.phone = '';
    UserProfile.address = '';
    UserProfile.rewardsPoints = 0;
    UserProfile.photoUrl = '';

    // Clear SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.setString('userId', '');

    // Navigate to welcome screen
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, '/welcome');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: buildAppBar(context, l10n.myProfile),
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
                const ProfileHeader(showDetails: true),
              ],
            ),
            const SizedBox(height: 30),
            _buildActionButtons(context),
            const SizedBox(height: 60),
            _buildLogoutButton(context),
            const SizedBox(height: 30),
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
          width: 90,
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
          width: 90,
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
          width: 90,
        ),
      ),
    ],
  );
}

Widget _buildLogoutButton(BuildContext context) {
  return GestureDetector(
    onTap: () => const ProfileScreen()._logout(context),
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
    height: 150,
    fit: BoxFit.cover,
  );
}


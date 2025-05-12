// lib/screens/home/profile_screen.dart
import 'package:flutter/material.dart';
import '../../widgets/title_notification.dart';

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
                _buildProfileHeader(context),
              ],
            ),
            const SizedBox(height: 30),
            _buildActionButtons(context),
            // const SizedBox(height: 30),
            // _buildLogoutButton(context),
            // const SizedBox(height: 50),
            // _buildFooterImage(context),
          ],
        ),
      ),
    );
  }
}

Widget _buildProfileHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35, left: 30, right: 50),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              // Shadowed profile background
              Container(
                width: 118,
                height: 118,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 9,
                      offset: const Offset(5, 4),
                    ),
                  ],
                ),
                child: Image.asset(
                  'assets/images/others/ProfilePicBackground.png',
                  fit: BoxFit.cover,
                ),
              ),
              ClipOval(
                child: Image.asset(
                  'assets/images/others/Profile.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          const SizedBox(width: 30),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Raymond Ling',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w900,
                      fontSize: 25, 
                    ),
                  ),
                  SizedBox(height: 2),
                  const Text(
                    'dmt2209669@xmu.edu.my',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 12, 
                    ),
                  ),
                  SizedBox(height: 5),
                  // Shadowed Edit button
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/edit'),
                    child: Image.asset(
                      'assets/images/buttons/EditButton.png',
                      width: 150,
                      height: 50,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

Widget _buildActionButtons(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/favourite'),
        child: Image.asset(
          'assets/images/buttons/FavouriteButton.png',
          width: 110,
        ),
      ),
      const SizedBox(width: 12),
      GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/balance'),
        child: Image.asset(
          'assets/images/buttons/BalanceButton.png',
          width: 110,
        ),
      ),
      const SizedBox(width: 12),
      GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/setting'),
        child: Image.asset(
          'assets/images/buttons/SettingButton.png',
          width: 110,
        ),
      ),
    ],
  );
}

// Widget _buildLogoutButton(BuildContext context) {
//   return ElevatedButton(
//     onPressed: () {},
//     style: ElevatedButton.styleFrom(
//       backgroundColor: const Color(0xFFCA3202),
//       padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
//     ),
//     child: const Text('Log Out', style: TextStyle(fontSize: 16)),
//   );
// }

// Widget _buildFooterImage(BuildContext context) {
//   return Image.asset(
//     'assets/images/others/footer.png', // Replace with your footer image asset path
//     height: 120,
//     fit: BoxFit.cover,
//   );
// }


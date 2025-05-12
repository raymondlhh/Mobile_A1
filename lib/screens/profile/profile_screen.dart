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
            // const SizedBox(height: 30),
            // _buildActionButtons(context),
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
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/images/others/ProfilePicBackground.png',
                width: 100,
                height: 100,
              ),
              ClipOval(
                child: Image.asset(
                  'assets/images/others/Profile.png',
                  width: 75,
                  height: 75,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Raymond Ling',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                    fontSize: 20, 
                  ),
                ),
                const Text(
                  'dmt2209669@xmu.edu.my',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 14, 
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/edit'),
                  child: Image.asset(
                    'assets/images/buttons/EditButton.png',
                    width: 120,
                    height: 40,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

// Widget _buildActionButtons(BuildContext context) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     children: [
//       _actionButton('Favourite', Icons.favorite, () {}),
//       _actionButton('Balance', Icons.account_balance_wallet, () {}),
//       _actionButton('Setting', Icons.settings, () {}),
//     ],
//   );
// }

// Widget _actionButton(String label, IconData icon, VoidCallback onPressed) {
//   return Column(
//     children: [
//       ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: const Color(0xFFA6C7A3),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           padding: const EdgeInsets.all(16),
//         ),
//         child: Icon(icon, size: 32, color: const Color(0xFFCA3202)),
//       ),
//       const SizedBox(height: 8),
//       Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
//     ],
//   );
// }

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


import 'package:flutter/material.dart';
import '../screens/profile/edit_screen.dart';

Widget buildProfileHeader(BuildContext context, {bool showDetails = true}) {
  final profileImage = Stack(
    alignment: Alignment.center,
    children: [
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
  );

  return Padding(
    padding: const EdgeInsets.only(top: 35, left: 30, right: 50),
    child: showDetails
        ? Row(
            children: [
              profileImage,
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
                      const SizedBox(height: 2),
                      const Text(
                        'dmt2209669@xmu.edu.my',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 5),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const EditScreen()),
                          );
                        },
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
          )
        : Align(
            alignment: const Alignment(0.1, 0), // adjust 0.1 → move a bit right, -0.1 = left
            child: profileImage,
        ),
  );
}

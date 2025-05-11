// lib/screens/home/profile_screen.dart
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});  // FIX key constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF8E5), // match background
        elevation: 0,
        centerTitle: true,
        title: const Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Text(
            'MY PROFILE',
            style: TextStyle(
              fontFamily: 'GaMaamli', 
              fontSize: 22,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 16,
              bottom: 20,
            ),
            child: Image.asset(
              'assets/images/icons/Notification.png',
              width: 24,
              height: 24,
            ),

          ),
        ],
      ),
      backgroundColor: const Color(0xFFFFF8E5), // also match screen background
      body: const Center(
        child: Text('My Profile Page Content'),
      ),
    );
  }
}

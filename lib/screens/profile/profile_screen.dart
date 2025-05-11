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
        title: const Text(
          'MY PROFILE',
          style: TextStyle(
            fontFamily: 'GaMaamli', 
            fontSize: 20,
            color: Colors.black,
            letterSpacing: 1.5,
          ),
        ),
      ),
      backgroundColor: const Color(0xFFFFF8E5), // also match screen background
      body: const Center(
        child: Text('My Profile Page Content'),
      ),
    );
  }
}

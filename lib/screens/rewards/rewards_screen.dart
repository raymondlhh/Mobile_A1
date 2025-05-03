// lib/screens/home/rewards_screen.dart
import 'package:flutter/material.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});  // FIX key constructor

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Rewards Screen',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

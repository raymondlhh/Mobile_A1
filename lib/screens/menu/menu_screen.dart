// lib/screens/home/menu_screen.dart
import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});  // FIX key constructor

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Menu Screen',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF8E5),
        elevation: 0,
        title: const Text(
          'Favourite',
          style: TextStyle(fontFamily: 'GaMaamli', color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: const Center(child: Text('Favourite Screen')),
    );
  }
}
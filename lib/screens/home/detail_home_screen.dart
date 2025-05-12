import 'package:flutter/material.dart';

class DetailHomeScreen extends StatelessWidget {
  const DetailHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password')),
      body: const Center(child: Text('This is the Forgot Password screen')),
    );
  }
}
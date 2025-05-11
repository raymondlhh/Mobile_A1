import 'package:flutter/material.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: Color(0xFFFFF8E5),
      ),
      body: const Center(
        child: Text('Edit Screen Content'),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../widgets/title_notification.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Edit Profile', showNotification: false),
      body: const Center(
        child: Text('Edit Screen Content'),
      ),
    );
  }
}

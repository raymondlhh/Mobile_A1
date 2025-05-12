import 'package:flutter/material.dart';
import '../../widgets/title_appbar.dart';
import '../../widgets/profile_description.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Edit Profile', actionType: AppBarActionType.tick),
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
                ProfileHeader(showDetails: false),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

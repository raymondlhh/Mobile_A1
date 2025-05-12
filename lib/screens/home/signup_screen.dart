import 'package:flutter/material.dart';
import '../../widgets/title_appbar.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Sign Up', actionType: AppBarActionType.none),
      body: const Center(child: Text('This is the Sign Up screen')),
    );
  }
}

import 'package:flutter/material.dart';
import '../../widgets/title_appbar.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Forgot Password', actionType: AppBarActionType.none),
      body: const Center(child: Text('This is the Forgot Password screen')),
    );
  }
}

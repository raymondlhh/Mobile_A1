import 'package:flutter/material.dart';

import '../../widgets/title_appbar.dart';

class BalanceScreen extends StatelessWidget {
  const BalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E5),
      appBar: buildAppBar(context, 'Balance', actionType: AppBarActionType.none),
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
                ],
              ),
            ],
          ),
        ),
      );
    }
  }
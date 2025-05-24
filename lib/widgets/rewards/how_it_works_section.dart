import 'package:flutter/material.dart';

class HowItWorksSection extends StatelessWidget {
  const HowItWorksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'How It Works',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Color(0xFF000000),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _HowItWorksItem(
                iconPath: 'assets/images/icons/reward_icon/left_icon.png',
                text: 'Earn rewards points\nevery order',
              ),
              _HowItWorksItem(
                iconPath: 'assets/images/icons/reward_icon/middle_icon.png',
                text: 'Redeem rewards with\nyour rewards points',
              ),
              _HowItWorksItem(
                iconPath: 'assets/images/icons/reward_icon/right_icon.png',
                text: 'Enjoy the amazing\nrewards!',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HowItWorksItem extends StatelessWidget {
  final String iconPath;
  final String text;

  const _HowItWorksItem({required this.iconPath, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(iconPath, width: 32, height: 32),
        const SizedBox(height: 4),
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 11, color: Color(0xFF000000)),
        ),
      ],
    );
  }
}

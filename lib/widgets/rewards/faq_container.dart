import 'package:flutter/material.dart';
import '../../screens/rewards/faq_screen.dart';

class FAQContainer extends StatelessWidget {
  const FAQContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF8AB98F),
      child: ListTile(
        title: const Text(
          'FAQ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF000000),
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Color(0xFF000000),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FAQScreen()),
          );
        },
      ),
    );
  }
}

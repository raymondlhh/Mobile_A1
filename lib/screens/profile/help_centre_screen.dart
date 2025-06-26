import 'package:flutter/material.dart';
import '../../widgets/title_appbar.dart';

class HelpCentreScreen extends StatelessWidget {
  const HelpCentreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E5),
      appBar: buildAppBar(context, 'HELP CENTRE', actionType: AppBarActionType.none),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: const [
            Text('Q1: How do I place an order?', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('A: Browse the menu, tap your desired items, and proceed to checkout from the cart.\n'),
            Text('Q2: Can I cancel or change my order after payment?', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('A: You can cancel within 5 minutes of placing the order. Changes are not allowed after payment is completed.\n'),
            Text('Q3: Where is delivery available?', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('A: Currently, we only deliver within Xiamen University Malaysia campus.\n'),
            Text('Q4: What payment methods are supported?', style: TextStyle(fontWeight: FontWeight.bold)),
            Text("A: We currently support Touch 'n Go eWallet (TNG) only.\n"),
            Text('Q5: My top-up failed. What should I do?', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('A: Check your internet connection and make sure your TNG account has sufficient balance.\n'),
            Text('Q6: How do I earn points?', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('A: You earn 1 point for every full RM 1 spent. Amounts below RM1 (e.g., RM1.50) will still count as 1 point - cents are not counted.\n'),
            Text('Q6: How do I redeem my points', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('A: Points can be redeemed at checkout for discounts.\n'),
          ],
        ),
      ),
    );
  }
} 
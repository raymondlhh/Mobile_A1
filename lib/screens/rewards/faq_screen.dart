import 'package:flutter/material.dart';
import '../../widgets/title_appbar.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F3E7),
      appBar: buildAppBar(context, 'REWARDS-FAQ'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'What are reward points?',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              "Reward points are a way for us to thank you for being a loyal customer! You earn these points every time you place an order through our food app. Once you've accumulated enough points, you can redeem them for exciting rewards, like discounts or free items.",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 16),
            Text(
              'How do I earn reward points?',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              "Earning points is easy! You'll automatically receive reward points for every successful order you place through our app. The exact number of points you earn may vary depending on the order total – check the details within the app for specifics on how many points you'll get for each order.",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 16),
            Text(
              'How can I use my reward points?',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              "You can redeem your accumulated reward points for various rewards offered within the app. These rewards might include discounts on your next order, free delivery, or even specific menu items. Check the 'Rewards' section of the app to see the available redemption options and the number of points required for each.",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 16),
            Text(
              'Do my reward points expire?',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              "Yes, reward points may have an expiration date. To ensure you don't lose your hard-earned points, please check the terms and conditions within the 'Rewards' section of the app for details on the expiration policy. We'll also try our best to notify you before your points are about to expire.",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 16),
            Text(
              'What if I have questions about my reward points or redemption?',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              "If you have any questions or need assistance regarding your reward points, please don't hesitate to contact our customer support team through the 'Help' or 'Contact Us' section of the app. We're always happy to help!",
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class DetailHomeScreen extends StatelessWidget {
  const DetailHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E5),
      body: SafeArea(
        child: Column(
          children: [
            // Title and Logo Section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '伝統的な',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'InknutAntiqua',
                        ),
                      ),
                      Container(
                        width: 80,
                        height: 80,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Image.asset(
                          'assets/images/icons/detail_home_screen/logo/logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      const Text(
                        '寿司',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'InknutAntiqua',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'OUR MENU',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),

            // Category Icons
            Container(
              height: 100,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildCategory('Teas', 'assets/images/icons/detail_home_screen/menu/tea_icon.png'),
                  _buildCategory('Rolls', 'assets/images/icons/detail_home_screen/menu/rolls_icon.png'),
                  _buildCategory('Salad', 'assets/images/icons/detail_home_screen/menu/salad_icon.png'),
                  _buildCategory('Soup', 'assets/images/icons/detail_home_screen/menu/soup_icon.png'),
                  _buildCategory('Gyoza', 'assets/images/icons/detail_home_screen/menu/gyoza_icon.png'),
                ],
              ),
            ),

            // Menu Items - Commented out for now
            /*
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildMenuItem(
                    'PARTY SET A',
                    '41 PCS',
                    'RM105.00',
                    'assets/images/icons/detail_home_screen/party_set_a.png',
                  ),
                  _buildMenuItem(
                    'MAKI SET',
                    '47 PCS',
                    'RM50.00',
                    'assets/images/icons/detail_home_screen/maki_set.png',
                  ),
                  _buildMenuItem(
                    'SUSHI SET',
                    '12 PCS',
                    'RM45.00',
                    'assets/images/icons/detail_home_screen/sushi_set.png',
                  ),
                  _buildMenuItem(
                    'TEMAKI SET',
                    '6 PCS',
                    'RM35.00',
                    'assets/images/icons/detail_home_screen/temaki_set.png',
                  ),
                ],
              ),
            ),
            */
          ],
        ),
      ),
    );
  }

  Widget _buildCategory(String title, String iconPath) {
    return Container(
      width: 80,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Image.asset(
              iconPath,
              width: 36,
              height: 36,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String title, String pieces, String price, String imagePath) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
            ),
          ),
          Text(
            pieces,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                price,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                  fontFamily: 'Inter',
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
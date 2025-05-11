import 'package:flutter/material.dart';
import '../screens/home/home_screen.dart';
import '../screens/menu/menu_screen.dart';
import '../screens/rewards/rewards_screen.dart';
import '../screens/profile/profile_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    MenuScreen(),
    RewardsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(child: _pages[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Supports 4+ items
        currentIndex: _currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/images/icons/HomeOriginal.png'),
              size: 20,
            ), 
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/images/icons/MenuOriginal.png'),
              size: 20,
            ),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/images/icons/RewardOriginal.png'),
              size: 20,
            ),
            label: 'Rewards',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/images/icons/ProfileOriginal.png'),
              size: 20,
            ), 
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
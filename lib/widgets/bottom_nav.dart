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
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFFFF8E5), // Set background color
          border: Border(
            top: BorderSide(color: Colors.black12, width: 1), // Divider line
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent, // Important to keep container color visible
          elevation: 0, // Remove shadow
          currentIndex: _currentIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Color(0xFFCA3202),
          unselectedItemColor: Color(0xFF000000),
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 6),
                child: ImageIcon(
                  AssetImage('assets/images/icons/HomeOriginal.png'),
                  size: 20,
                ),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 6),
                child: ImageIcon(
                  AssetImage('assets/images/icons/MenuOriginal.png'),
                  size: 20,
                ),
              ),
              label: 'Menu',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 6),
                child: ImageIcon(
                  AssetImage('assets/images/icons/RewardOriginal.png'),
                  size: 20,
                ),
              ),
              label: 'Rewards',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 6),
                child: ImageIcon(
                  AssetImage('assets/images/icons/ProfileOriginal.png'),
                  size: 20,
                ),
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
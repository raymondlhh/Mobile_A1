import 'package:flutter/material.dart';
import '../screens/home/detail_home_screen.dart';
import '../screens/menu/menu_screen.dart';
import '../screens/rewards/rewards_screen.dart';
import '../screens/profile/profile_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DetailHomeScreen(),
    const MenuScreen(),
    const RewardsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFFFF8E5),
          border: Border(top: BorderSide(color: Colors.black12, width: 2)),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: _selectedIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: const Color(0xFFCA3202),
          unselectedItemColor: const Color(0xFF000000),
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 10, bottom: 1),
                child: ImageIcon(AssetImage('assets/images/icons/Home.png'), size: 20),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 10, bottom: 1),
                child: ImageIcon(AssetImage('assets/images/icons/Menu.png'), size: 20),
              ),
              label: 'Menu',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 10, bottom: 1),
                child: ImageIcon(AssetImage('assets/images/icons/Reward.png'), size: 20),
              ),
              label: 'Rewards',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 10, bottom: 1),
                child: ImageIcon(AssetImage('assets/images/icons/Profile.png'), size: 20),
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

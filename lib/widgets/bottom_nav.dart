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
  int _currentIndex = 0;

  final List<Widget> _pages = [
    DetailHomeScreen(),
    MenuScreen(),
    RewardsScreen(),
    const NavigatorWrapper(child: ProfileScreen()),
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
            top: BorderSide(color: Colors.black12, width: 2), // Divider line
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
                padding: EdgeInsets.only(
                  top: 10,
                  bottom: 1,
                ),
                child: ImageIcon(
                  AssetImage('assets/images/icons/Home.png'),
                  size: 20,
                ),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  bottom: 1,
                ),
                child: ImageIcon(
                  AssetImage('assets/images/icons/Menu.png'),
                  size: 20,
                ),
              ),
              label: 'Menu',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  bottom: 1,
                ),
                child: ImageIcon(
                  AssetImage('assets/images/icons/Reward.png'),
                  size: 20,
                ),
              ),
              label: 'Rewards',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  bottom: 1,
                ),
                child: ImageIcon(
                  AssetImage('assets/images/icons/Profile.png'),
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

class NavigatorWrapper extends StatelessWidget {
  final Widget child;

  const NavigatorWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (_) => child,
        );
      },
    );
  }
}
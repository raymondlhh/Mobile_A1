// lib/screens/home/menu_screen.dart
import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F3E6),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110),
        child: Column(
          children: [
            AppBar(
              backgroundColor: const Color(0xFFF8F3E6),
              elevation: 0,
              toolbarHeight: 50,
              title: Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.black),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: "AEON NILAI, NEGERI SEMBILAN",
                        items: [
                          DropdownMenuItem(
                            value: "AEON NILAI, NEGERI SEMBILAN",
                            child: Text("AEON NILAI, NEGERI SEMBILAN"),
                          ),
                        ],
                        onChanged: (_) {},
                        style: const TextStyle(color: Colors.black),
                        icon: const Icon(Icons.arrow_drop_down),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "OPEN",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search for your favourite sushi",
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Row(
        children: [
          // Side Navigation
          Container(
            width: 80,
            color: const Color(0xFFF8F3E6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                _SideNavItem(icon: 'assets/party_set.png', label: 'PARTY SET'),
                _SideNavItem(
                  icon: 'assets/appetizers.png',
                  label: 'APPETIZERS',
                ),
                _SideNavItem(icon: 'assets/maki_roll.png', label: 'MAKI ROLL'),
                _SideNavItem(icon: 'assets/nigiri.png', label: 'NIGIRI'),
                _SideNavItem(icon: 'assets/gunkan.png', label: 'GUNKAN'),
                _SideNavItem(
                  icon: 'assets/condiments.png',
                  label: 'CONDIMENTS',
                ),
              ],
            ),
          ),
          // Menu Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _MenuCategory(
                    title: "PARTY SET",
                    items: [
                      _MenuItem(
                        image: 'assets/party_set_a.png',
                        name: 'PARTY SET A (81 PCS)',
                        price: 'RM 109.90',
                      ),
                      _MenuItem(
                        image: 'assets/party_set_b.png',
                        name: 'PARTY SET B (74 PCS)',
                        price: 'RM 99.90',
                      ),
                    ],
                  ),
                  _MenuCategory(
                    title: "APPETIZERS",
                    items: [
                      _MenuItem(
                        image: 'assets/chiuka_idako.png',
                        name: 'CHUKA IDAKO',
                        price: 'RM 7.90',
                      ),
                      _MenuItem(
                        image: 'assets/chiuka_kurage.png',
                        name: 'CHUKA KURAGE',
                        price: 'RM 8.90',
                      ),
                      _MenuItem(
                        image: 'assets/mochi.png',
                        name: 'MOCHI (4PCS)',
                        price: 'RM 6.90',
                      ),
                    ],
                  ),
                  // Add more categories as needed...
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.white,
      ),
    );
  }
}

// Side Navigation Item Widget
class _SideNavItem extends StatelessWidget {
  final String icon;
  final String label;
  const _SideNavItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Image.asset(icon, width: 40, height: 40),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Menu Category Widget
class _MenuCategory extends StatelessWidget {
  final String title;
  final List<_MenuItem> items;
  const _MenuCategory({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'PermanentMarker',
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(spacing: 16, runSpacing: 16, children: items),
      ],
    );
  }
}

// Menu Item Widget
class _MenuItem extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  const _MenuItem({
    required this.image,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      decoration: BoxDecoration(
        color: const Color(0xFFB6C7A8),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(image, width: 100, height: 100),
          ),
          Container(
            color: const Color(0xFFD35400),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  price,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

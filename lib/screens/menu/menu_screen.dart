import 'package:flutter/material.dart';
import '../../data/menu_data.dart';
import 'item_detail_page.dart';
import '../../models/menu_item.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  static const List<String> branches = [
    "AEON Nilai, Negeri Sembilan",
    "Mid Valley Megamall, Kuala Lumpur",
    "Sunway Pyramid, Selangor",
    "Gurney Plaza, Penang",
    "Paradigm Mall, Johor Bahru",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E5),
      body: SafeArea(
        child: Column(
          children: [
            // Top Row 1: Branch Selector
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.black),
                  const SizedBox(width: 8),
                  Expanded(child: _BranchDropdown()),
                  const SizedBox(width: 12),
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
            // Top Row 2: Search Bar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search for your favourite sushi",
                          prefixIcon: Icon(Icons.search),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Horizontal Divider
            const Padding(
              padding: EdgeInsets.only(top: 12),
              child: Divider(thickness: 1, height: 1, color: Colors.black26),
            ),
            // Main Content: Side Nav + Menu
            Expanded(
              child: Row(
                children: [
                  // Side Navigation (Scrollable)
                  Container(
                    width: 90,
                    color: const Color(0xFF7F7F7F),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          SizedBox(height: 16),
                          _SideNavItem(
                            icon:
                                'assets/images/icons/menu_sidebar/party_set.png',
                            label: 'PARTY SET',
                          ),
                          _SideNavItem(
                            icon:
                                'assets/images/icons/menu_sidebar/appetizers.png',
                            label: 'APPETIZERS',
                          ),
                          _SideNavItem(
                            icon:
                                'assets/images/icons/menu_sidebar/maki_roll.png',
                            label: 'MAKI ROLL',
                          ),
                          _SideNavItem(
                            icon: 'assets/images/icons/menu_sidebar/nigiri.png',
                            label: 'NIGIRI',
                          ),
                          _SideNavItem(
                            icon: 'assets/images/icons/menu_sidebar/gunkan.png',
                            label: 'GUNKAN',
                          ),
                          _SideNavItem(
                            icon:
                                'assets/images/icons/menu_sidebar/condiments.png',
                            label: 'CONDIMENTS',
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                  // Vertical Divider
                  const VerticalDivider(
                    width: 1,
                    thickness: 1,
                    color: Color(0xFF7F7F7F),
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
                                image:
                                    'assets/images/foods/party_set/party_set_a.png',
                                name: 'PARTY SET A (81 PCS)',
                                price: 'RM 109.90',
                              ),
                              _MenuItem(
                                image:
                                    'assets/images/foods/party_set/party_set_b.png',
                                name: 'PARTY SET B (74 PCS)',
                                price: 'RM 99.90',
                              ),
                            ],
                          ),
                          _MenuCategory(
                            title: "APPETIZERS",
                            items: [
                              _MenuItem(
                                image:
                                    'assets/images/foods/appetizers/chuka_idako.png',
                                name: 'CHUKA IDAKO',
                                price: 'RM 7.90',
                              ),
                              _MenuItem(
                                image:
                                    'assets/images/foods/appetizers/chuka_kurage.png',
                                name: 'CHUKA KURAGE',
                                price: 'RM 8.90',
                              ),
                              _MenuItem(
                                image:
                                    'assets/images/foods/appetizers/mochi.png',
                                name: 'MOCHI (4PCS)',
                                price: 'RM 6.90',
                              ),
                            ],
                          ),
                          _MenuCategory(
                            title: "MAKI ROLL",
                            items: [
                              _MenuItem(
                                image:
                                    'assets/images/foods/maki_rolls/sake_maki.png',
                                name: 'SAKE MAKI',
                                price: 'RM 5.90',
                              ),
                              _MenuItem(
                                image:
                                    'assets/images/foods/maki_rolls/tamago_maki.png',
                                name: 'TAMAGO MAKI',
                                price: 'RM 4.90',
                              ),
                            ],
                          ),
                          _MenuCategory(
                            title: "NIGIRI",
                            items: [
                              _MenuItem(
                                image:
                                    'assets/images/foods/nigiri/kani_mentai.png',
                                name: 'KANI MENTAI',
                                price: 'RM 6.90',
                              ),
                              _MenuItem(
                                image:
                                    'assets/images/foods/nigiri/tamago_mentai.png',
                                name: 'TAMAGO MENTAI',
                                price: 'RM 6.50',
                              ),
                            ],
                          ),
                          _MenuCategory(
                            title: "GUNKAN",
                            items: [
                              _MenuItem(
                                image: 'assets/images/foods/gunkan/ebiko.png',
                                name: 'EBIKO',
                                price: 'RM 7.90',
                              ),
                              _MenuItem(
                                image:
                                    'assets/images/foods/gunkan/kani_mayo.png',
                                name: 'KANI MAYO',
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
            ),
          ],
        ),
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
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12, width: 2),
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Image.asset(icon, width: 36, height: 36),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              fontFamily: 'PermanentMarker',
            ),
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
    // Find the MenuItem instance from dummy data by name (or another unique field)
    final menuItem = menuItems.firstWhere(
      (item) => item.name == name,
      orElse:
          () => MenuItem(
            name: name,
            price: price,
            imagePath: image,
            ratings: 5.0,
            reviews: [],
            description: '',
          ),
    );
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemDetailPage(menuItem: menuItem),
          ),
        );
      },
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          color: const Color(0xFF8AB98F),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFCA3202),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(image, width: 100, height: 100),
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFFCA3202),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
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
                      fontFamily: 'PermanentMarker',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    price,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'PermanentMarker',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Add this widget below the MenuScreen class
class _BranchDropdown extends StatefulWidget {
  @override
  State<_BranchDropdown> createState() => _BranchDropdownState();
}

class _BranchDropdownState extends State<_BranchDropdown> {
  String selectedBranch = MenuScreen.branches[0];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: selectedBranch,
        items:
            MenuScreen.branches
                .map(
                  (branch) =>
                      DropdownMenuItem(value: branch, child: Text(branch)),
                )
                .toList(),
        onChanged: (value) {
          if (value != null) {
            setState(() {
              selectedBranch = value;
            });
          }
        },
        style: const TextStyle(color: Colors.black),
        icon: const Icon(Icons.arrow_drop_down),
      ),
    );
  }
}

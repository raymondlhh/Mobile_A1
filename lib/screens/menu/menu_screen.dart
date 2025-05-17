import 'package:flutter/material.dart';
import '../../data/menu_data.dart';
import 'item_detail_page.dart';
import '../../models/menu_item.dart';

class MenuScreen extends StatefulWidget {
  final String? initialSection;
  const MenuScreen({this.initialSection, super.key});

  static const List<String> branches = [
    "AEON Nilai, Negeri Sembilan",
    "Mid Valley Megamall, Kuala Lumpur",
    "Sunway Pyramid, Selangor",
    "Gurney Plaza, Penang",
    "Paradigm Mall, Johor Bahru",
  ];

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _sectionKeys = {
    'PARTY SET': GlobalKey(),
    'APPETIZERS': GlobalKey(),
    'MAKI ROLL': GlobalKey(),
    'NIGIRI': GlobalKey(),
    'GUNKAN': GlobalKey(),
    'CURRY SET': GlobalKey(),
    'CONDIMENTS': GlobalKey(),
    'DRINKS': GlobalKey(),
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateSectionOffsets();
      if (widget.initialSection != null) {
        _scrollToSection(widget.initialSection!);
      }
    });
  }

  void _calculateSectionOffsets() {
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    for (final section in _sectionKeys.keys) {
      _sectionKeys[section] = GlobalKey();
      // Approximate height of each section (adjust based on your content)
    }
  }

  void _scrollToSection(String section) {
    final key = _sectionKeys[section];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        alignment: 0.0,
      );
    }
  }

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
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.black12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: _BranchDropdown(),
                    ),
                  ),
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
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Top Row 2: Search Bar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: SearchBar(
                leading: const Icon(Icons.search),
                hintText: 'Find your favourite sushi!',
                backgroundColor: WidgetStateProperty.all(Colors.grey[100]),
                shadowColor: WidgetStateProperty.all(Colors.black),
                elevation: WidgetStateProperty.all(2.0),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
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
                    color: const Color(0xFFFFF8E5),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          _SideNavItem(
                            icon:
                                'assets/images/icons/menu_sidebar/party_set.png',
                            label: 'PARTY SET',
                            onTap: () => _scrollToSection('PARTY SET'),
                          ),
                          _SideNavItem(
                            icon:
                                'assets/images/icons/menu_sidebar/appetizers.png',
                            label: 'APPETIZERS',
                            onTap: () => _scrollToSection('APPETIZERS'),
                          ),
                          _SideNavItem(
                            icon:
                                'assets/images/icons/menu_sidebar/maki_roll.png',
                            label: 'MAKI ROLL',
                            onTap: () => _scrollToSection('MAKI ROLL'),
                          ),
                          _SideNavItem(
                            icon: 'assets/images/icons/menu_sidebar/nigiri.png',
                            label: 'NIGIRI',
                            onTap: () => _scrollToSection('NIGIRI'),
                          ),
                          _SideNavItem(
                            icon: 'assets/images/icons/menu_sidebar/gunkan.png',
                            label: 'GUNKAN',
                            onTap: () => _scrollToSection('GUNKAN'),
                          ),
                          _SideNavItem(
                            icon:
                                'assets/images/icons/menu_sidebar/curry_set.png',
                            label: 'CURRY SET',
                            onTap: () => _scrollToSection('CURRY SET'),
                          ),
                          _SideNavItem(
                            icon:
                                'assets/images/icons/menu_sidebar/condiments.png',
                            label: 'CONDIMENTS',
                            onTap: () => _scrollToSection('CONDIMENTS'),
                          ),
                          _SideNavItem(
                            icon: 'assets/images/icons/menu_sidebar/drinks.png',
                            label: 'DRINKS',
                            onTap: () => _scrollToSection('DRINKS'),
                          ),
                          const SizedBox(height: 16),
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
                      controller: _scrollController,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _MenuCategory(
                            key: _sectionKeys['PARTY SET'],
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
                              _MenuItem(
                                image:
                                    'assets/images/foods/party_set/party_set_c.png',
                                name: 'PARTY SET C (65 PCS)',
                                price: 'RM 89.90',
                              ),
                              _MenuItem(
                                image:
                                    'assets/images/foods/party_set/maki_set.png',
                                name: 'MAKI SET (30 PCS)',
                                price: 'RM 49.90',
                              ),
                              _MenuItem(
                                image:
                                    'assets/images/foods/party_set/nigiri_set.png',
                                name: 'NIGIRI SET (25 PCS)',
                                price: 'RM 59.90',
                              ),
                              _MenuItem(
                                image:
                                    'assets/images/foods/party_set/gunkan_set.png',
                                name: 'GUNKAN SET (20 PCS)',
                                price: 'RM 45.90',
                              ),
                            ],
                          ),
                          _MenuCategory(
                            key: _sectionKeys['APPETIZERS'],
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
                            key: _sectionKeys['MAKI ROLL'],
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
                              _MenuItem(
                                image:
                                    'assets/images/foods/maki_rolls/kappa_maki.png',
                                name: 'KAPPA MAKI',
                                price: 'RM 4.90',
                              ),
                              _MenuItem(
                                image:
                                    'assets/images/foods/maki_rolls/kani_maki.png',
                                name: 'KANI MAKI',
                                price: 'RM 5.90',
                              ),
                            ],
                          ),
                          _MenuCategory(
                            key: _sectionKeys['NIGIRI'],
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
                              _MenuItem(
                                image:
                                    'assets/images/foods/nigiri/ebi_nigiri.png',
                                name: 'EBI NIGIRI',
                                price: 'RM 6.90',
                              ),
                              _MenuItem(
                                image:
                                    'assets/images/foods/nigiri/ika_nigiri.png',
                                name: 'IKA NIGIRI',
                                price: 'RM 6.90',
                              ),
                              _MenuItem(
                                image:
                                    'assets/images/foods/nigiri/sake_nigiri.png',
                                name: 'SAKE NIGIRI',
                                price: 'RM 7.90',
                              ),
                              _MenuItem(
                                image:
                                    'assets/images/foods/nigiri/tako_nigiri.png',
                                name: 'TAKO NIGIRI',
                                price: 'RM 6.90',
                              ),
                              _MenuItem(
                                image:
                                    'assets/images/foods/nigiri/unagi_nigiri.png',
                                name: 'UNAGI NIGIRI',
                                price: 'RM 7.90',
                              ),
                            ],
                          ),
                          _MenuCategory(
                            key: _sectionKeys['GUNKAN'],
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
                              _MenuItem(
                                image:
                                    'assets/images/foods/gunkan/lobster_salad_gunkan.png',
                                name: 'LOBSTER SALAD GUNKAN',
                                price: 'RM 8.90',
                              ),
                            ],
                          ),
                          _MenuCategory(
                            key: _sectionKeys['CURRY SET'],
                            title: "CURRY SET",
                            items: [
                              _MenuItem(
                                image:
                                    'assets/images/foods/curry_sets/chicken_katsu_curry_don.png',
                                name: 'CHICKEN KATSU CURRY DON',
                                price: 'RM 18.90',
                              ),
                              _MenuItem(
                                image:
                                    'assets/images/foods/curry_sets/ebi_curry_don.png',
                                name: 'EBI CURRY DON',
                                price: 'RM 19.90',
                              ),
                              _MenuItem(
                                image:
                                    'assets/images/foods/curry_sets/chicken_katsu_curry_udon.png',
                                name: 'CHICKEN KATSU CURRY UDON',
                                price: 'RM 19.90',
                              ),
                              _MenuItem(
                                image:
                                    'assets/images/foods/curry_sets/ebi_curry_udon.png',
                                name: 'EBI CURRY UDON',
                                price: 'RM 20.90',
                              ),
                            ],
                          ),
                          _MenuCategory(
                            key: _sectionKeys['CONDIMENTS'],
                            title: "CONDIMENTS",
                            items: [
                              _MenuItem(
                                image:
                                    'assets/images/foods/condiments/soy_sauce.png',
                                name: 'SOY SAUCE',
                                price: 'RM 0.20',
                              ),
                              _MenuItem(
                                image:
                                    'assets/images/foods/condiments/wasabi.png',
                                name: 'WASABI',
                                price: 'RM 0.40',
                              ),
                              _MenuItem(
                                image:
                                    'assets/images/foods/condiments/ginger.png',
                                name: 'GINGER',
                                price: 'RM 1.00',
                              ),
                            ],
                          ),
                          _MenuCategory(
                            key: _sectionKeys['DRINKS'],
                            title: "DRINKS",
                            items: [
                              _MenuItem(
                                image: 'assets/images/foods/drinks/coke.png',
                                name: 'COKE',
                                price: 'RM 3.90',
                              ),
                              _MenuItem(
                                image: 'assets/images/foods/drinks/sprite.png',
                                name: 'SPRITE',
                                price: 'RM 3.90',
                              ),
                              _MenuItem(
                                image: 'assets/images/foods/drinks/100plus.png',
                                name: '100PLUS',
                                price: 'RM 3.90',
                              ),
                              _MenuItem(
                                image:
                                    'assets/images/foods/drinks/oyoshi_green_tea.png',
                                name: 'OYOSHI GREEN TEA',
                                price: 'RM 4.90',
                              ),
                            ],
                          ),
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
  final VoidCallback onTap;
  const _SideNavItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
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
      ),
    );
  }
}

// Menu Category Widget
class _MenuCategory extends StatelessWidget {
  final String title;
  final List<_MenuItem> items;
  const _MenuCategory({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Inter',
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
        width: 125,
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
                      fontSize: 14,
                      fontFamily: 'Inter',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    price,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Inter',
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

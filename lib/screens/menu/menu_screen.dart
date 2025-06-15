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
  final TextEditingController _searchController = TextEditingController();
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

  // Add a map to store filtered items for each category
  final Map<String, List<_MenuItem>> _filteredItems = {};
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    // Initialize section keys once
    for (final section in _sectionKeys.keys) {
      _sectionKeys[section] = GlobalKey();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialSection != null) {
        _scrollToSection(widget.initialSection!);
      }
    });
  }

  // dispose TextEditingController for search bar aftter use
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _scrollToSection(String section) {
    final key = _sectionKeys[section];
    if (key == null) {
      debugPrint('Section $section not found');
      return;
    }

    if (key.currentContext == null) {
      debugPrint('Context for section $section is not available');
      return;
    }

    try {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        alignment: 0.0,
      );
    } catch (e) {
      debugPrint('Error scrolling to section $section: $e');
    }
  }

  void _filterMenuItems(String query) {
    setState(() {
      _isSearching = query.isNotEmpty;
      if (query.isEmpty) {
        _filteredItems.clear();
        return;
      }

      // Filter items in each category
      for (final category in _sectionKeys.keys) {
        _filteredItems[category] =
            menuItems
                .where((item) {
                  final isInCategory = item.imagePath.contains(
                    category.toLowerCase().replaceAll(' ', '_'),
                  );
                  final matchesSearch = item.name.toLowerCase().contains(
                    query.toLowerCase(),
                  );
                  return isInCategory && matchesSearch;
                })
                .map(
                  (item) => _MenuItem(
                    image: item.imagePath,
                    name: item.name,
                    price: item.price,
                  ),
                )
                .toList();
      }
    });
  }

  List<_MenuItem> _getCategoryItems(String category) {
    // Get items from menu_data.dart based on image path
    return menuItems
        .where(
          (item) => item.imagePath.contains(
            category.toLowerCase().replaceAll(' ', '_'),
          ),
        )
        .map(
          (item) => _MenuItem(
            image: item.imagePath,
            name: item.name,
            price: item.price,
          ),
        )
        .toList();
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
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.black, size: 30),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 180),
                        child: _BranchDropdown(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: () {
                      // TODO: Implement shopping cart functionality
                    },
                  ),
                ],
              ),
            ),
            // Top Row 2: Search Bar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: SearchBar(
                controller: _searchController,
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
                onChanged: _filterMenuItems,
                onSubmitted: _filterMenuItems,
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
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
                            items: _getCategoryItems('PARTY SET'),
                            isSearching: _isSearching,
                            filteredItems: _filteredItems['PARTY SET'],
                          ),
                          _MenuCategory(
                            key: _sectionKeys['APPETIZERS'],
                            title: "APPETIZERS",
                            items: _getCategoryItems('APPETIZERS'),
                            isSearching: _isSearching,
                            filteredItems: _filteredItems['APPETIZERS'],
                          ),
                          _MenuCategory(
                            key: _sectionKeys['MAKI ROLL'],
                            title: "MAKI ROLL",
                            items: _getCategoryItems('MAKI ROLL'),
                            isSearching: _isSearching,
                            filteredItems: _filteredItems['MAKI ROLL'],
                          ),
                          _MenuCategory(
                            key: _sectionKeys['NIGIRI'],
                            title: "NIGIRI",
                            items: _getCategoryItems('NIGIRI'),
                            isSearching: _isSearching,
                            filteredItems: _filteredItems['NIGIRI'],
                          ),
                          _MenuCategory(
                            key: _sectionKeys['GUNKAN'],
                            title: "GUNKAN",
                            items: _getCategoryItems('GUNKAN'),
                            isSearching: _isSearching,
                            filteredItems: _filteredItems['GUNKAN'],
                          ),
                          _MenuCategory(
                            key: _sectionKeys['CURRY SET'],
                            title: "CURRY SET",
                            items: _getCategoryItems('CURRY SET'),
                            isSearching: _isSearching,
                            filteredItems: _filteredItems['CURRY SET'],
                          ),
                          _MenuCategory(
                            key: _sectionKeys['CONDIMENTS'],
                            title: "CONDIMENTS",
                            items: _getCategoryItems('CONDIMENTS'),
                            isSearching: _isSearching,
                            filteredItems: _filteredItems['CONDIMENTS'],
                          ),
                          _MenuCategory(
                            key: _sectionKeys['DRINKS'],
                            title: "DRINKS",
                            items: _getCategoryItems('DRINKS'),
                            isSearching: _isSearching,
                            filteredItems: _filteredItems['DRINKS'],
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
                fontSize: 9,
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
  final bool isSearching;
  final List<_MenuItem>? filteredItems;

  const _MenuCategory({
    super.key,
    required this.title,
    required this.items,
    this.isSearching = false,
    this.filteredItems,
  });

  @override
  Widget build(BuildContext context) {
    final displayItems =
        isSearching && filteredItems != null ? filteredItems! : items;

    if (isSearching && (filteredItems == null || filteredItems!.isEmpty)) {
      return const SizedBox.shrink();
    }

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
        Wrap(spacing: 16, runSpacing: 16, children: displayItems),
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
            reviews: const [],
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
        width: 120,
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
                color: Color(0xFF8AB98F),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ),
                  Text(
                    price,
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                      fontSize: 12,
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
        style: const TextStyle(
          color: Colors.black,
          fontSize: 12,
          fontFamily: 'Inter',
        ),
        icon: const Icon(Icons.arrow_drop_down),
      ),
    );
  }
}

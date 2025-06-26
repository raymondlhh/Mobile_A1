import 'package:flutter/material.dart';
// ignore: unused_import
import '../menu/menu_screen.dart';
import '../menu/item_detail_page.dart';
import '../../models/menu_item.dart';
import '../../data/menu_data.dart';
import '../../services/favourite_service.dart';
import '../../models/user_profile.dart';

class DetailHomeScreen extends StatefulWidget {
  const DetailHomeScreen({super.key});

  @override
  _DetailHomeScreenState createState() => _DetailHomeScreenState();
}

class _DetailHomeScreenState extends State<DetailHomeScreen> {
  String selectedCategory = 'Party Set';
  List<MenuItem> displayedItems = [];

  @override
  void initState() {
    super.initState();
    _updateDisplayedItems();
    _loadUserFavourites();
  }

  void _updateDisplayedItems() {
    final items =
        menuItems
            .where(
              (item) => item.imagePath.toLowerCase().contains(
                selectedCategory.toLowerCase().replaceAll(' ', '_'),
              ),
            )
            .toList();
    items.shuffle();
    setState(() {
      displayedItems = items.take(2).toList();
    });
  }

  Future<void> _loadUserFavourites() async {
    if (UserProfile.userId.isNotEmpty) {
      await FavouriteService().loadFavourites();
    }
  }

  @override
  Widget build(BuildContext context) {
    // 设置基准尺寸
    const designWidth = 430.0;
    const designHeight = 932.0;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E5),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final scaleWidth = constraints.maxWidth / designWidth;
          final scaleHeight = constraints.maxHeight / designHeight;

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                children: [
                  SizedBox(height: 60 * scaleHeight),
                  SizedBox(
                    height: 186 * scaleHeight,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Background Image
                        Positioned(
                          top: 0,
                          left: 0,
                          width: 430 * scaleWidth,
                          height: 200 * scaleHeight,
                          child: Image.asset(
                            'assets/images/icons/detail_home_screen/beijing.png',
                            fit: BoxFit.cover,
                            opacity: const AlwaysStoppedAnimation(0.3),
                          ),
                        ),
                        // 左侧文字
                        Positioned(
                          left: (65 / designWidth) * constraints.maxWidth,
                          top: 5 * scaleHeight,
                          bottom: 5 * scaleHeight,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                '伝',
                                style: TextStyle(
                                  fontSize: 24 * scaleWidth,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Noto Serif JP',
                                  height: 1.2,
                                ),
                              ),
                              Text(
                                '統',
                                style: TextStyle(
                                  fontSize: 24 * scaleWidth,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Noto Serif JP',
                                  height: 1.2,
                                ),
                              ),
                              Text(
                                '的',
                                style: TextStyle(
                                  fontSize: 24 * scaleWidth,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Noto Serif JP',
                                  height: 1.2,
                                ),
                              ),
                              Text(
                                'な',
                                style: TextStyle(
                                  fontSize: 24 * scaleWidth,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Noto Serif JP',
                                  height: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 中间Logo
                        Center(
                          child: Transform.translate(
                            offset: const Offset(0, 22),
                            child: Image.asset(
                              'assets/images/icons/welcome_screen/Logo.png',
                              width: (200 / designWidth) * constraints.maxWidth,
                              height:
                                  (200 / designWidth) * constraints.maxWidth,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // 右侧文字
                        Positioned(
                          right: (65 / designWidth) * constraints.maxWidth,
                          top: 5 * scaleHeight,
                          bottom: 5 * scaleHeight,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                '寿',
                                style: TextStyle(
                                  fontSize: 24 * scaleWidth,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Noto Serif JP',
                                  height: 1.2,
                                ),
                              ),
                              Text(
                                '司',
                                style: TextStyle(
                                  fontSize: 24 * scaleWidth,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Noto Serif JP',
                                  height: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Featured Section - 移到分类之前
                  Padding(
                    padding: EdgeInsets.only(top: 20 * scaleHeight),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16 * scaleWidth),
                          child: Text(
                            'Featured',
                            style: TextStyle(
                              fontSize: 18 * scaleWidth,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                        SizedBox(height: 10 * scaleHeight),
                        SizedBox(
                          height: 120 * scaleHeight,
                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(
                              horizontal: 12 * scaleWidth,
                            ),
                            children: [
                              _buildFeaturedItem(
                                'Limited Time Offer',
                                '20% OFF\nParty Set B',
                                'assets/images/icons/detail_home_screen/partset1.png',
                                scaleWidth,
                                scaleHeight,
                              ),
                              _buildFeaturedItem(
                                'New Arrival',
                                'Premium\nSashimi Set',
                                'assets/images/icons/detail_home_screen/partset2.png',
                                scaleWidth,
                                scaleHeight,
                              ),
                              _buildFeaturedItem(
                                'Member Special',
                                'Free Tea\nwith any Set',
                                'assets/images/icons/detail_home_screen/tea_icon.png',
                                scaleWidth,
                                scaleHeight,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Category Section with title
                  Padding(
                    padding: EdgeInsets.only(top: 10 * scaleHeight),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16 * scaleWidth),
                          child: Text(
                            'Categories',
                            style: TextStyle(
                              fontSize: 18 * scaleWidth,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                        SizedBox(height: 10 * scaleHeight),
                        // Category Icons Section
                        Container(
                          height: 110 * scaleHeight,
                          margin: EdgeInsets.only(left: 8 * scaleWidth),
                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedCategory = 'Party Set';
                                    _updateDisplayedItems();
                                  });
                                },
                                child: _buildCategory(
                                  'Party Set',
                                  'assets/images/icons/menu_sidebar/party_set.png',
                                  scaleWidth,
                                  scaleHeight,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedCategory = 'Appetizers';
                                    _updateDisplayedItems();
                                  });
                                },
                                child: _buildCategory(
                                  'Appetizers',
                                  'assets/images/icons/menu_sidebar/appetizers.png',
                                  scaleWidth,
                                  scaleHeight,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedCategory = 'Maki Roll';
                                    _updateDisplayedItems();
                                  });
                                },
                                child: _buildCategory(
                                  'Maki Roll',
                                  'assets/images/icons/menu_sidebar/maki_roll.png',
                                  scaleWidth,
                                  scaleHeight,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedCategory = 'Nigiri';
                                    _updateDisplayedItems();
                                  });
                                },
                                child: _buildCategory(
                                  'Nigiri',
                                  'assets/images/icons/menu_sidebar/nigiri.png',
                                  scaleWidth,
                                  scaleHeight,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedCategory = 'Gunkan';
                                    _updateDisplayedItems();
                                  });
                                },
                                child: _buildCategory(
                                  'Gunkan',
                                  'assets/images/icons/menu_sidebar/gunkan.png',
                                  scaleWidth,
                                  scaleHeight,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedCategory = 'Curry Set';
                                    _updateDisplayedItems();
                                  });
                                },
                                child: _buildCategory(
                                  'Curry Set',
                                  'assets/images/icons/menu_sidebar/curry_set.png',
                                  scaleWidth,
                                  scaleHeight,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedCategory = 'Condiments';
                                    _updateDisplayedItems();
                                  });
                                },
                                child: _buildCategory(
                                  'Condiments',
                                  'assets/images/icons/menu_sidebar/condiments.png',
                                  scaleWidth,
                                  scaleHeight,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedCategory = 'Drinks';
                                    _updateDisplayedItems();
                                  });
                                },
                                child: _buildCategory(
                                  'Drinks',
                                  'assets/images/icons/menu_sidebar/drinks.png',
                                  scaleWidth,
                                  scaleHeight,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Menu Items Section
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      16 * scaleWidth,
                      0,
                      16 * scaleWidth,
                      16 * scaleHeight,
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: displayedItems.length,
                      itemBuilder: (context, index) {
                        final item = displayedItems[index];
                        return _buildMenuItem(
                          context,
                          item,
                          scaleWidth,
                          scaleHeight,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategory(
    String title,
    String iconPath,
    double scaleWidth,
    double scaleHeight,
  ) {
    return Container(
      width: 90 * scaleWidth,
      margin: EdgeInsets.symmetric(horizontal: 8 * scaleWidth),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 50 * scaleWidth,
            height: 50 * scaleWidth,
            padding: EdgeInsets.all(2 * scaleWidth),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E5),
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(iconPath, fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: 5 * scaleHeight),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12 * scaleWidth,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    MenuItem item,
    double scaleWidth,
    double scaleHeight,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemDetailPage(menuItem: item),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8 * scaleHeight),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        color: const Color(0xFF8AB98F),
        child: Padding(
          padding: EdgeInsets.all(12 * scaleWidth),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 90 * scaleWidth,
                height: 90 * scaleWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(item.imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 12 * scaleWidth),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: TextStyle(
                        fontSize: 16 * scaleWidth,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4 * scaleHeight),
                    Text(
                      item.description,
                      style: TextStyle(
                        fontSize: 13 * scaleWidth,
                        fontFamily: 'Inter',
                        color: Colors.grey[700],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 6 * scaleHeight),
                    Text(
                      item.price,
                      style: TextStyle(
                        fontSize: 15 * scaleWidth,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedItem(
    String tag,
    String title,
    String imagePath,
    double scaleWidth,
    double scaleHeight,
  ) {
    return Container(
      width: 160 * scaleWidth,
      margin: EdgeInsets.symmetric(horizontal: 6 * scaleWidth),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: const Color(0xFFFFF8E5),
        child: Stack(
          children: [
            Positioned(
              right: -20 * scaleWidth,
              bottom: -15 * scaleHeight,
              child: Opacity(
                opacity: 0.3,
                child: Image.asset(
                  imagePath,
                  width: 100 * scaleWidth,
                  height: 100 * scaleWidth,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12 * scaleWidth),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8 * scaleWidth,
                      vertical: 4 * scaleHeight,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFCA3202),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      tag,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10 * scaleWidth,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8 * scaleHeight),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16 * scaleWidth,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
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

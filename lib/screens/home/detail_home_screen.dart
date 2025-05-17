import 'package:flutter/material.dart';

class DetailHomeScreen extends StatelessWidget {
  const DetailHomeScreen({super.key});

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
                  // 顶部区域（包含背景图、文字和logo）
                  SizedBox(
                    height: 180 * scaleHeight,
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
                          child: Container(
                            width: (155 / designWidth) * constraints.maxWidth,
                            height: (155 / designWidth) * constraints.maxWidth,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFCA3202),
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/icons/detail_home_screen/logo.png',
                                fit: BoxFit.cover,
                              ),
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
                    padding: EdgeInsets.only(top: 20 * scaleHeight),
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
                              _buildCategory(
                                'Teas',
                                'assets/images/icons/detail_home_screen/tea_icon.png',
                                scaleWidth,
                                scaleHeight,
                              ),
                              _buildCategory(
                                'Rolls',
                                'assets/images/icons/detail_home_screen/rolls_icon.png',
                                scaleWidth,
                                scaleHeight,
                              ),
                              _buildCategory(
                                'Salad',
                                'assets/images/icons/detail_home_screen/salad_icon.png',
                                scaleWidth,
                                scaleHeight,
                              ),
                              _buildCategory(
                                'Soup',
                                'assets/images/icons/detail_home_screen/soup_icon.png',
                                scaleWidth,
                                scaleHeight,
                              ),
                              _buildCategory(
                                'Gyoza',
                                'assets/images/icons/detail_home_screen/gyoza_icon.png',
                                scaleWidth,
                                scaleHeight,
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
                      15 * scaleHeight,
                      16 * scaleWidth,
                      16 * scaleHeight,
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return _buildMenuItem(index, scaleWidth, scaleHeight);
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
      width: 80 * scaleWidth,
      margin: EdgeInsets.symmetric(horizontal: 8 * scaleWidth),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 75 * scaleWidth,
            height: 75 * scaleWidth,
            padding: EdgeInsets.all(2 * scaleWidth),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E5),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
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
              fontSize: 14 * scaleWidth,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(int index, double scaleWidth, double scaleHeight) {
    List<Map<String, String>> menuItems = [
      {
        'name': 'Party Set A (81 PCS)',
        'price': 'RM110.00',
        'description': 'A large assortment of sushi rolls for your party.',
        'image': 'assets/images/icons/detail_home_screen/partset1.png',
      },
      {
        'name': 'Maki Set (47 PCS)',
        'price': 'RM59.90',
        'description':
            'A variety of maki rolls including tuna, salmon, and avocado.',
        'image': 'assets/images/icons/detail_home_screen/partset2.png',
      },
    ];

    return Card(
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
                  image: AssetImage(menuItems[index]['image']!),
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
                    menuItems[index]['name']!,
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
                    menuItems[index]['description']!,
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
                    menuItems[index]['price']!,
                    style: TextStyle(
                      fontSize: 15 * scaleWidth,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2E7D32),
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

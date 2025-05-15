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
            child: Column(
              // 改用Column作为主要容器
              children: [
                SizedBox(height: 100 * scaleHeight), // 从45增加到60，增加顶部间距
                // 顶部区域（包含背景图、文字和logo）
                Container(
                  width: double.infinity,
                  height: 200 * scaleHeight, // 减少容器高度
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Background Image
                      Positioned(
                        top: 0 * scaleHeight, // 从-20改为0，让背景图下移
                        left: 0,
                        width: 430 * scaleWidth,
                        height: 250 * scaleHeight,
                        child: Image.asset(
                          'assets/images/icons/detail_home_screen/beijing.png',
                          fit: BoxFit.cover,
                          opacity: const AlwaysStoppedAnimation(0.3),
                        ),
                      ),
                      // 左侧文字
                      Positioned(
                        left: (36 / designWidth) * constraints.maxWidth,
                        top: 0,
                        bottom: 0,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                '伝',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Noto Serif JP',
                                  height: 1.5,
                                ),
                              ),
                              Text(
                                '統',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Noto Serif JP',
                                  height: 1.5,
                                ),
                              ),
                              Text(
                                '的',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Noto Serif JP',
                                  height: 1.5,
                                ),
                              ),
                              Text(
                                'な',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Noto Serif JP',
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // 中间Logo
                      Center(
                        child: Container(
                          width: (190.28 / designWidth) * constraints.maxWidth,
                          height: (190.28 / designWidth) * constraints.maxWidth,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFCA3202),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/icons/detail_home_screen/logo.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      // 右侧文字
                      Positioned(
                        right: (36 / designWidth) * constraints.maxWidth,
                        top: 0,
                        bottom: 0,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                '寿',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Noto Serif JP',
                                  height: 1.5,
                                  letterSpacing: 8,
                                ),
                              ),
                              Text(
                                '司',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Noto Serif JP',
                                  height: 1.5,
                                  letterSpacing: 8,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // OUR MENU and Category Section
                Container(
                  margin: EdgeInsets.only(
                    top: 15 * scaleHeight,
                  ), // 从30减少到15，减少顶部间距
                  child: Column(
                    children: [
                      // OUR MENU text
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(top: 5 * scaleHeight),
                        child: Text(
                          'OUR MENU',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize:
                                (28 / designHeight) * constraints.maxHeight,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                            fontFamily: 'Overlock',
                          ),
                        ),
                      ),

                      // Category Icons Section
                      Container(
                        height: 120 * scaleHeight,
                        margin: EdgeInsets.only(left: 8 * scaleWidth),
                        width: constraints.maxWidth,
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
                Container(
                  margin: EdgeInsets.only(top: 20 * scaleHeight), // 添加顶部间距
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16 * scaleWidth),
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
                ),
              ],
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
      width: 85 * scaleWidth,
      margin: EdgeInsets.symmetric(horizontal: 8 * scaleWidth),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start, // 改为顶部对齐
        children: [
          Container(
            width: 85 * scaleWidth,
            height: 85 * scaleWidth,
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
              child: Image.asset(iconPath, fit: BoxFit.fill),
            ),
          ),
          SizedBox(height: 10 * scaleHeight), // 增加图片和文字之间的间距
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16 * scaleWidth, // 从12增加到16
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
        'image': 'assets/images/icons/detail_home_page/partset1.png',
      },
      {
        'name': 'Maki Set (47 PCS)',
        'price': 'RM59.90',
        'description':
            'A variety of maki rolls including tuna, salmon, and avocado.',
        'image': 'assets/images/icons/detail_home_page/partset2.png',
      },
    ];

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8 * scaleHeight),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      color: const Color(0xFF8AB98F),
      child: Container(
        padding: EdgeInsets.all(16 * scaleWidth),
        child: Row(
          children: [
            Container(
              width: 100 * scaleWidth,
              height: 100 * scaleHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(menuItems[index]['image']!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 16 * scaleWidth),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    menuItems[index]['name']!,
                    style: TextStyle(
                      fontSize: 20 * scaleWidth,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                    ),
                  ),
                  SizedBox(height: 4 * scaleHeight),
                  Text(
                    menuItems[index]['description']!,
                    style: TextStyle(
                      fontSize: 16 * scaleWidth,
                      fontFamily: 'Inter',
                      color: Colors.grey[700],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8 * scaleHeight),
                  Text(
                    menuItems[index]['price']!,
                    style: TextStyle(
                      fontSize: 18 * scaleWidth,
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
}

import 'package:flutter/material.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 获取屏幕的宽度和高度
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF3E7),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo: 距离顶部约 10% 屏幕高度，宽度居中，占 50%
            SizedBox(height: screenHeight * 0.1),
            Image.asset(
              'assets/images/icons/welcome_screen/Logo.png',
              width: screenWidth * 0.5,  // 居中，宽度占 50%
              height: screenWidth * 0.5, // 高度与宽度保持一致
              fit: BoxFit.contain,
            ),
            SizedBox(height: screenHeight * 0.05), // Logo 下方的间距

            // 标题部分: 大约占 10% - 12% 屏幕高度
            Text(
              '臺川寿司', // Title in Japanese
              style: TextStyle(
                fontSize: screenWidth * 0.12, // 字体大小占宽度的 12%
                fontWeight: FontWeight.w700, // 更粗的字体
                fontFamily: 'NotoSerifJP',
                letterSpacing: 1.2,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black45,
                    offset: Offset(3.0, 3.0),
                  ),
                ], // 增加阴影效果
              ),
            ),
            SizedBox(height: screenHeight * 0.02), // 标题下方的间距

            // 副标题部分: 占屏幕高度的 8%-10%
            Text(
              'KIKAWA NJITYO\nJAPANESE CUISINE',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: screenWidth * 0.05, // 占屏幕宽度的 5%
                fontWeight: FontWeight.w500,
                letterSpacing: 1,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: screenHeight * 0.02), // 副标题下方的间距

            // 更小的文本: 占屏幕高度的 5%
            Text(
              'ちず・めじじら　お',
              style: TextStyle(
                fontSize: screenWidth * 0.04, // 占屏幕宽度的 4%
                fontWeight: FontWeight.w300,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: screenHeight * 0.05), // 与按钮部分的间距

            // Sign up 按钮: 占屏幕高度的 8% 左右，按钮宽度占屏幕的 70%-80%
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1), // 居中，水平占 80%
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9CC9A4),
                  foregroundColor: Colors.black,
                  elevation: 6, // 轻微的阴影效果
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02), // 高度占屏幕的 2%
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // 圆角更大
                  ),
                ),
                onPressed: () => Navigator.pushNamed(context, '/signup'),
                child: Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: screenWidth * 0.05, // 字体大小占宽度的 5%
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02), // 按钮之间的间距

            // Login 按钮: 同样样式，按钮之间有间距
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1), // 居中，水平占 80%
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  elevation: 6, // 轻微的阴影效果
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02), // 高度占屏幕的 2%
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // 圆角更大
                  ),
                ),
                onPressed: () => Navigator.pushNamed(context, '/login'),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: screenWidth * 0.05, // 字体大小占宽度的 5%
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02), // 按钮之间的间距

            // Forgot Password 文本: 位于底部，距底部约 10%
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/forgot'),
              child: Text(
                'Forget your password ?',
                style: TextStyle(color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

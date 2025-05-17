// import 'package:flutter/material.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Login')),
//       body: const Center(child: Text('This is the Login screen')),
//     );
//   }
// }

import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF3E7),
      body: SafeArea(
        child: Stack(
          children: [
            // Red Logo - 居中显示
            Positioned(
              left: (screenWidth - (screenWidth * 250 / 430)) / 2, // 居中计算
              top: screenHeight * -20 / 932,
              child: Image.asset(
                'assets/images/icons/welcome_screen/Logo.png',
                width: screenWidth * 250 / 430,
                height: screenHeight * 375 / 932,
                fit: BoxFit.contain,
              ),
            ),

            // Text Image - 居中显示
            Positioned(
              left: (screenWidth - (screenWidth * 294 / 430)) / 2, // 居中计算
              top: screenHeight * 240 / 932,
              child: Image.asset(
                'assets/images/icons/welcome_screen/subtitle.png',
                width: screenWidth * 294 / 430,
                fit: BoxFit.contain,
              ),
            ),

            // Email Input
            Positioned(
              left: screenWidth * 41 / 430,
              top: screenHeight * 500 / 932,
              child: Container(
                width: screenWidth * 337 / 430,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(
                      fontSize: screenWidth * 16 / 430,
                      color: Colors.grey,
                    ),
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 16 / 430,
                      vertical: screenHeight * 16 / 932,
                    ),
                  ),
                ),
              ),
            ),

            // Password Input
            Positioned(
              left: screenWidth * 41 / 430,
              top: screenHeight * 570 / 932,
              child: Container(
                width: screenWidth * 337 / 430,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      fontSize: screenWidth * 16 / 430,
                      color: Colors.grey,
                    ),
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 16 / 430,
                      vertical: screenHeight * 16 / 932,
                    ),
                  ),
                ),
              ),
            ),

            // Login Button
            Positioned(
              left: screenWidth * 41 / 430,
              top: screenHeight * 650 / 932,
              child: GestureDetector(
                onTap: () {
                  // TODO: 这里可以添加邮箱和密码的验证逻辑
                  Navigator.pushReplacementNamed(context, '/bottomNav');
                },
                child: Container(
                  width: screenWidth * 337 / 430,
                  height: screenHeight * 53 / 932,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 5,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontFamily: 'InknutAntiqua',
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 30 / 430,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

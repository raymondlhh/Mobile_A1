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
import '../../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    // Validate email format
    if (!_authService.isValidEmail(email)) {
      setState(() {
        _errorMessage = 'Please enter a valid email address';
        _isLoading = false;
      });
      return;
    }

    // Validate password
    if (password.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter your password';
        _isLoading = false;
      });
      return;
    }

    try {
      final isValid = await _authService.validateUser(email, password);
      if (isValid) {
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/bottomNav');
        }
      } else {
        setState(() {
          _errorMessage = 'Invalid email or password';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred. Please try again.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
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

            // Error Message
            if (_errorMessage != null)
              Positioned(
                left: screenWidth * 41 / 430,
                top: screenHeight * 450 / 932,
                child: Container(
                  width: screenWidth * 337 / 430,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red.shade900, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
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
                  enabled: !_isLoading,
                  keyboardType: TextInputType.emailAddress,
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
                  enabled: !_isLoading,
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
                      onPressed:
                          _isLoading
                              ? null
                              : () {
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
<<<<<<< HEAD
                onTap: _isLoading ? null : _handleLogin,
=======
                onTap: () {
                  // TODO: integrate FirebaseAuth sign in
                  Navigator.pushReplacementNamed(context, '/bottomNav');
                },
>>>>>>> b2e54a01041a7778b2270b24967b6589f023a913
                child: Container(
                  width: screenWidth * 337 / 430,
                  height: screenHeight * 53 / 932,
                  decoration: BoxDecoration(
                    color: _isLoading ? Colors.grey : Colors.black,
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
                    child:
                        _isLoading
                            ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                            : Text(
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

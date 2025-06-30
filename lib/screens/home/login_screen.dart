import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../services/auth_service.dart';
import '../../services/favourite_service.dart';

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
    final l10n = AppLocalizations.of(context)!;

    // Validate email format
    if (!_authService.isValidEmail(email)) {
      setState(() {
        _errorMessage = l10n.pleaseEnterValidEmail;
        _isLoading = false;
      });
      return;
    }

    // Validate password
    if (password.isEmpty) {
      setState(() {
        _errorMessage = l10n.pleaseEnterPassword;
        _isLoading = false;
      });
      return;
    }

    try {
      final isValid = await _authService.validateUser(email, password);
      if (isValid) {
        await FavouriteService().loadFavourites();
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/videoSplash');
        }
      } else {
        setState(() {
          _errorMessage = l10n.invalidEmailOrPassword;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = l10n.errorOccurredTryAgain;
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
    final l10n = AppLocalizations.of(context)!;

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
                    hintText: l10n.email,
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
                    hintText: l10n.password,
                    hintStyle: TextStyle(
                      fontSize: screenWidth * 16 / 430,
                      color: Colors.grey,
                    ),
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 16 / 430,
                      vertical: screenHeight * 16 / 932,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
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
                onTap: _isLoading ? null : _handleLogin,
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
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            l10n.login,
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

            // Forgot Password
            Positioned(
              left: screenWidth * 120 / 430,
              top: screenHeight * 720 / 932,
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/forgot'),
                child: Text(
                  l10n.forgotPassword,
                  style: const TextStyle(
                    color: Colors.black87,
                    decoration: TextDecoration.underline,
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

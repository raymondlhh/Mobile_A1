import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  int _selectedMethod = 0; // 0: Phone, 1: Email

  late AnimationController _animController;
  late Animation<double> _logoOpacity;
  late Animation<double> _formOpacity;
  late Animation<Offset> _formOffset;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _logoOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );
    _formOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
      ),
    );
    _formOffset = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
      ),
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
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
            // Logo with fade-in
            Positioned(
              left: (screenWidth - (screenWidth * 250 / 430)) / 2,
              top: screenHeight * -20 / 932,
              child: AnimatedBuilder(
                animation: _logoOpacity,
                builder:
                    (context, child) =>
                        Opacity(opacity: _logoOpacity.value, child: child),
                child: Image.asset(
                  'assets/images/icons/welcome_screen/Logo.png',
                  width: screenWidth * 250 / 430,
                  height: screenHeight * 375 / 932,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            // Subtitle (无动画，和logo一起出现)
            Positioned(
              left: (screenWidth - (screenWidth * 294 / 430)) / 2,
              top: screenHeight * 240 / 932,
              child: Image.asset(
                'assets/images/icons/welcome_screen/subtitle.png',
                width: screenWidth * 294 / 430,
                fit: BoxFit.contain,
              ),
            ),
            // Animated form area (method switch, input, button, back)
            AnimatedBuilder(
              animation: _formOpacity,
              builder:
                  (context, child) => Opacity(
                    opacity: _formOpacity.value,
                    child: SlideTransition(position: _formOffset, child: child),
                  ),
              child: Column(
                children: [
                  // Method Switch Buttons
                  SizedBox(height: screenHeight * 460 / 932),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 41 / 430,
                    ),
                    child: Container(
                      width: screenWidth * 337 / 430,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha((0.08 * 255).toInt()),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedMethod = 0;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      _selectedMethod == 0
                                          ? const Color(0xFF8AB98F)
                                          : Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'By Phone',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        _selectedMethod == 0
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedMethod = 1;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      _selectedMethod == 1
                                          ? const Color(0xFF8AB98F)
                                          : Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'By Email',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        _selectedMethod == 1
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 40 / 932),
                  // Input Field
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 41 / 430,
                    ),
                    child: Container(
                      width: screenWidth * 337 / 430,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha((0.1 * 255).toInt()),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child:
                          _selectedMethod == 0
                              ? TextField(
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  hintText: 'Phone Number',
                                  hintStyle: TextStyle(
                                    fontSize: screenWidth * 16 / 430,
                                    color: Colors.grey,
                                  ),
                                  prefixIcon: const Icon(Icons.phone_outlined),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 16 / 430,
                                    vertical: screenHeight * 16 / 932,
                                  ),
                                ),
                              )
                              : TextField(
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
                  SizedBox(height: screenHeight * 40 / 932),
                  // Send Button
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 41 / 430,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        // Todo: Implement send code or reset link logic
                      },
                      child: Container(
                        width: screenWidth * 337 / 430,
                        height: screenHeight * 53 / 932,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(
                                (0.2 * 255).toInt(),
                              ),
                              blurRadius: 5,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            _selectedMethod == 0
                                ? 'Send Code'
                                : 'Send Reset Link',
                            style: TextStyle(
                              fontFamily: 'InknutAntiqua',
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 22 / 430,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 40 / 932),
                  // Back to Login Button
                  Padding(
                    padding: EdgeInsets.only(left: screenWidth * 120 / 430),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: const Text('Back to Login'),
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

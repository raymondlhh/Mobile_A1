// ignore_for_file: deprecated_member_use, unused_field

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  bool _emailFound = false;
  String? _userDocId;

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
    _newPasswordController.dispose();
    super.dispose();
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
            // 邮箱输入框
            Positioned(
              left: screenWidth * 41 / 430,
              top: screenHeight * 530 / 932,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
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
                      enabled: !_emailFound,
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
                  if (_emailFound) ...[
                    const SizedBox(height: 16),
                    Container(
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
                        controller: _newPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: l10n.newPassword,
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
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            // 查找邮箱按钮
            if (!_emailFound)
              Positioned(
                left: screenWidth * 41 / 430,
                top: screenHeight * 610 / 932,
                child: GestureDetector(
                  onTap: () async {
                    final email = _emailController.text.trim();
                    if (email.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(l10n.pleaseEnterEmail),
                        ),
                      );
                      return;
                    }
                    final users =
                        await FirebaseFirestore.instance
                            .collection('users')
                            .where('email', isEqualTo: email)
                            .get();
                    if (users.docs.isNotEmpty) {
                      setState(() {
                        _emailFound = true;
                        _userDocId = users.docs.first.id;
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(l10n.emailNotFound),
                        ),
                      );
                    }
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
                        l10n.findEmail,
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
            // 重置密码按钮
            if (_emailFound)
              Positioned(
                left: screenWidth * 41 / 430,
                top: screenHeight * 610 / 932,
                child: GestureDetector(
                  onTap: () async {
                    final newPassword = _newPasswordController.text;
                    if (newPassword.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(l10n.pleaseEnterNewPassword),
                        ),
                      );
                      return;
                    }
                    if (newPassword.length < 6) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(l10n.passwordTooShort),
                        ),
                      );
                      return;
                    }
                    try {
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(_userDocId)
                          .update({'password': newPassword});
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(l10n.passwordResetSuccess),
                          ),
                        );
                        Navigator.of(context).pop();
                      }
                    } catch (e) {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(l10n.passwordResetFailed),
                          ),
                        );
                      }
                    }
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
                        l10n.resetPassword,
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

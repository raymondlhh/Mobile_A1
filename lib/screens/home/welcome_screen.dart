import 'package:flutter/material.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF3E7), // Light beige background
      body: SafeArea(
        child: Stack(
          children: [
            // Red Logo
            Positioned(
              left: screenWidth * 41/ 430,
              top: screenHeight * -50 / 932,
              child: Image.asset(
                'assets/images/icons/welcome_screen/Logo.png',
                width: screenWidth * 350 / 430,
                height: screenHeight * 525 / 932,
                fit: BoxFit.contain,
              ),
            ),
            
            // Text Image
<<<<<<< HEAD

            Positioned(
              left: screenWidth * 65 / 430,
              top: screenHeight * 320 / 932,
              child: Image.asset(
                'assets/images/icons/welcome_screen/subtitle.png',
                width: screenWidth * 294 / 430,
                fit: BoxFit.contain,
              ),
            ),

=======
            // Positioned(
            //   left: screenWidth * 55 / 430,
            //   top: screenHeight * 339 / 932,
            //   child: Image.asset(
            //     'assets/images/icons/welcome_screen/full_text_image.png',
            //     width: screenWidth * 294 / 430,
            //     fit: BoxFit.contain,
            //   ),
            // ),
>>>>>>> d057c0f93cfe74b994b57694ea7e2c79338922f8
            
            // Sign Up Button (Green BG, Black Text, Gray Stroke)
            Positioned(
              left: screenWidth * 41 / 430,
              top: screenHeight * 600 / 932,
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/signup'),
                child: Container(
                  width: screenWidth * 332 / 430,
                  height: screenHeight * 53 / 932,
                  decoration: BoxDecoration(
                    color: const Color(0xFF8AB98F), // Green background
                    border: Border.all(
                      color: const Color(0xFF7F7F7F), // Gray stroke
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        fontFamily: 'InknutAntiqua',
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 30 / 430,
                        color: Colors.black, // Black text
                      ),
                    ),
                  ),
                ),
              ),
            ),
            
            // Login Button (Black BG, White Text)
            Positioned(
              left: screenWidth * 41 / 430,
              top: screenHeight * 677/ 932,
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/login'),
                child: Container(
                  width: screenWidth * 337 / 430,
                  height: screenHeight * 53 / 932,
                  decoration: BoxDecoration(
                    color: Colors.black, // Black background
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
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
                        color: Colors.white, // White text
                      ),
                    ),
                  ),
                ),
              ),
            ),
            
            // Forget Password (Underlined, Clickable)
            Positioned(
              left: screenWidth * 120 / 430,
              top: screenHeight * 760 / 932,
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/forgot'),
                child: Text(
                  'Forget your password ?',
                  style: TextStyle(
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

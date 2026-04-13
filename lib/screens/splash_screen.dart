import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(_controller);
    _controller.forward();

    // الانتقال إلى الشاشة الرئيسية بعد 2.5 ثانية
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFB71C1C), // أحمر شطة
              const Color(0xFFD32F2F),
              Colors.white,
            ],
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // شعار مؤقت (يمكنك استبداله بصورة)
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '♜',
                        style: TextStyle(
                          fontSize: 80,
                          color: const Color(0xFFB71C1C),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'شطة',
                          style: GoogleFonts.cairo(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFB71C1C),
                            shadows: [
                              Shadow(blurRadius: 5, color: Colors.black26),
                            ],
                          ),
                        ),
                        TextSpan(
                          text: ' ',
                          style: GoogleFonts.cairo(fontSize: 48),
                        ),
                        TextSpan(
                          text: 'رنج',
                          style: GoogleFonts.cairo(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(blurRadius: 5, color: Colors.black26),
                              Shadow(offset: Offset(1, 1), color: Color(0xFFFFD700)), // ذهبي
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 100,
                    height: 3,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFD700),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(blurRadius: 5, color: Colors.amber.shade300),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

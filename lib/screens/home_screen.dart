import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'game_screen.dart';
import 'settings_screen.dart';
import '../models/game_state.dart';
import '../widgets/custom_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context);
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFB71C1C),
              const Color(0xFF8B0000),
              Colors.black87,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // الهيدر مع الاسم
              const SizedBox(height: 40),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'شطة',
                      style: GoogleFonts.cairo(
                        fontSize: 56,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFB71C1C),
                        shadows: [Shadow(blurRadius: 10, color: Colors.black)],
                      ),
                    ),
                    TextSpan(
                      text: ' ',
                    ),
                    TextSpan(
                      text: 'رنج',
                      style: GoogleFonts.cairo(
                        fontSize: 56,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(blurRadius: 10, color: Colors.black),
                          Shadow(offset: Offset(1, 1), color: const Color(0xFFFFD700)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 120,
                height: 3,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFD700),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 60),
              // الأزرار الرئيسية
              CustomButton(
                text: '▶ لعب سريع',
                onPressed: () {
                  gameState.resetGame();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GameScreen()),
                  );
                },
                icon: Icons.play_arrow,
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: '⚙ الإعدادات',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SettingsScreen()),
                  );
                },
                icon: Icons.settings,
              ),
              const Spacer(),
              // معلومات الإصدار
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'الإصدار 1.0.0',
                  style: GoogleFonts.cairo(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

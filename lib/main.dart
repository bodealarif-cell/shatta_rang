import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/splash_screen.dart';
import 'models/game_state.dart';

void main() {
  runApp(const ShattaRangApp());
}

class ShattaRangApp extends StatelessWidget {
  const ShattaRangApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GameState(),
      child: MaterialApp(
        title: 'شطة رنج',
        theme: ThemeData.light().copyWith(
          primaryColor: const Color(0xFFB71C1C), // أحمر شطة
          scaffoldBackgroundColor: Colors.white,
          textTheme: GoogleFonts.cairoTextTheme(),
        ),
        darkTheme: ThemeData.dark().copyWith(
          primaryColor: const Color(0xFFB71C1C),
          scaffoldBackgroundColor: const Color(0xFF1A1A2E),
          textTheme: GoogleFonts.cairoTextTheme(ThemeData.dark().textTheme),
        ),
        themeMode: ThemeMode.system,
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

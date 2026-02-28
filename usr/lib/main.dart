import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GeoMind',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
      },
    );
  }

  ThemeData _buildTheme() {
    final base = ThemeData.dark();
    
    return base.copyWith(
      scaffoldBackgroundColor: const Color(0xFF0F111A), // Very dark blue-grey
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF8B5CF6), // Violet
        secondary: Color(0xFFEC4899), // Pink
        surface: Color(0xFF1E293B), // Slate 800
        background: Color(0xFF0F111A),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Color(0xFFE2E8F0), // Slate 200
      ),
      textTheme: GoogleFonts.poppinsTextTheme(base.textTheme).apply(
        bodyColor: const Color(0xFFE2E8F0),
        displayColor: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      cardTheme: CardTheme(
        color: const Color(0xFF1E293B),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4,
        shadowColor: Colors.black54,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF1E293B),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF8B5CF6), width: 2),
        ),
        hintStyle: TextStyle(color: Colors.grey[500]),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF8B5CF6),
        foregroundColor: Colors.white,
      ),
    );
  }
}

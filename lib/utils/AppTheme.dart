import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF4A90E2);
  static const Color secondary = Color(0xFF7B68EE);
  static const Color surfaceLight = Color(0xFFF5F7FB);

  static ThemeData light() {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: surfaceLight,
    );

    return base.copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.white,
        titleTextStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          letterSpacing: 0.5,
        ),
      ),
      textTheme: base.textTheme.copyWith(
        headlineMedium: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: const TextStyle(fontSize: 16),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: primary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          padding: const EdgeInsets.all(16),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        hintStyle: TextStyle(color: Colors.grey.shade400),
      ),
    );
  }
}

class WeatherVisuals {
  static List<Color> gradientFor(String condition) {
    final c = condition.toLowerCase();
    if (c.contains('sun') || c.contains('clear')) {
      return const [Color(0xFF56CCF2), Color(0xFF2F80ED)];
    }
    if (c.contains('rain') || c.contains('drizzle') || c.contains('shower')) {
      return const [Color(0xFF3A6073), Color(0xFF16222A)];
    }
    if (c.contains('cloud') || c.contains('overcast') || c.contains('mist') || c.contains('fog')) {
      return const [Color(0xFF757F9A), Color(0xFFD7DDE8)];
    }
    if (c.contains('snow') || c.contains('sleet') || c.contains('ice')) {
      return const [Color(0xFFE0EAFC), Color(0xFFCFDEF3)];
    }
    if (c.contains('thunder') || c.contains('storm')) {
      return const [Color(0xFF232526), Color(0xFF414345)];
    }
    return const [Color(0xFF4A90E2), Color(0xFF7B68EE)];
  }

  static IconData iconFor(String condition) {
    final c = condition.toLowerCase();
    if (c.contains('sun') || c.contains('clear')) return Icons.wb_sunny_rounded;
    if (c.contains('rain') || c.contains('drizzle') || c.contains('shower')) return Icons.grain_rounded;
    if (c.contains('thunder') || c.contains('storm')) return Icons.thunderstorm_rounded;
    if (c.contains('snow') || c.contains('sleet') || c.contains('ice')) return Icons.ac_unit_rounded;
    if (c.contains('cloud') || c.contains('overcast')) return Icons.wb_cloudy_rounded;
    if (c.contains('mist') || c.contains('fog')) return Icons.foggy;
    return Icons.wb_sunny_rounded;
  }
}
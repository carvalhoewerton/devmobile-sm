import 'package:flutter/material.dart';

class SMTheme {
  // Colors
  static const Color primary = Color(0xFF1A3A6B);
  static const Color background = Color(0xFF1E4E8C);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color inputBorder = Color(0xFFDDE1E7);
  static const Color inputFill = Color(0xFFF9FAFB);
  static const Color hintText = Color(0xFFADB5BD);
  static const Color labelText = Color(0xFF495057);
  static const Color linkColor = Color(0xFF1A6DC8);
  static const Color buttonColor = Color(0xFF1A3A6B);
  static const Color buttonText = Color(0xFFFFFFFF);
  static const Color logoCircle = Color(0xFF1A3A6B);
  static const Color subtleText = Color(0xFF6C757D);
  static const Color bodyText = Color(0xFF212529);

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: background,
    );
  }
}

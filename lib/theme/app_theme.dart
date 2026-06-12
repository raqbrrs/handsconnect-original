# 1. ATUALIZANDO O TEMA (lib/theme/app_theme.dart)
import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF004AAD);      // O Azul do seu logotipo/botões
  static const Color secondary = Color(0xFFE6F0FA);    // Azul bem clarinho dos cards secundários
  static const Color background = Color(0xFFFFFFFF);   // Fundo Branco Puro
  static const Color textDark = Color(0xFF1A1A1A);     // Texto Preto
  static const Color textLight = Color(0xFF757575);    // Texto Cinza

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: primary,
      scaffoldBackgroundColor: background,
      colorScheme: const ColorScheme.light(primary: primary, secondary: secondary, surface: background),
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        elevation: 0,
        iconTheme: IconThemeData(color: textDark),
        titleTextStyle: TextStyle(color: textDark, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF5F7FA),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: primary, width: 2)),
      ),
    );
  }
}

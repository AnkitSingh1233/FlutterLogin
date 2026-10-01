import 'package:flutter/material.dart';

class AppColors {
  // Brand Gradients
  static const Color primary = Color(0xFF6366F1); // Indigo
  static const Color primaryLight = Color(0xFF818CF8);
  static const Color primaryDark = Color(0xFF4F46E5);
  static const Color secondary = Color(0xFF8B5CF6); // Purple / Violet
  static const Color accent = Color(0xFFEC4899); // Pink accent
  static const Color cyan = Color(0xFF06B6D4);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6), Color(0xFFD946EF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient backgroundGradientDark = LinearGradient(
    colors: [Color(0xFF090D16), Color(0xFF0F172A), Color(0xFF131127)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient cardGradientDark = LinearGradient(
    colors: [Color(0x33334155), Color(0x1A1E293B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Dark Theme Colors
  static const Color bgDark = Color(0xFF090D16);
  static const Color surfaceDark = Color(0xFF131C31);
  static const Color cardDark = Color(0xFF1E293B);
  static const Color inputBgDark = Color(0xFF0F172A);
  static const Color borderDark = Color(0xFF334155);
  static const Color borderFocused = Color(0xFF6366F1);
  static const Color textPrimaryDark = Color(0xFFF8FAFC);
  static const Color textSecondaryDark = Color(0xFF94A3B8);
  static const Color textMutedDark = Color(0xFF64748B);

  // Light Theme Colors
  static const Color bgLight = Color(0xFFF8FAFC);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color inputBgLight = Color(0xFFF1F5F9);
  static const Color borderLight = Color(0xFFE2E8F0);
  static const Color textPrimaryLight = Color(0xFF0F172A);
  static const Color textSecondaryLight = Color(0xFF475569);
  static const Color textMutedLight = Color(0xFF94A3B8);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);
}

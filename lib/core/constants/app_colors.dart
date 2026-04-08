import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF5B67F1);
  static const Color secondary = Color(0xFF8EA2FF);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF5B67F1), Color(0xFF8EA2FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient splashGradient = LinearGradient(
    colors: [Color(0xFF6B83FA), Color(0xFF8B9DFC)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Color background = Color(0xFFF5F7FB);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFE2E8F0);

  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textLight = Color(0xFFCBD5F5);

  static const Color success = Color(0xFF22C55E);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);

  static const Color inputBackground = Color(0xFFFFFFFF);
  static const Color inputBorder = Color(0xFFE2E8F0);
  static const Color inputFocused = Color(0xFF5B67F1);
  static const Color disabled = Color(0xFFE5E7EB);

  static const Color navActive = Color(0xFF5B67F1);
  static const Color navInactive = Color(0xFFA0AEC0);
  static const Color navActiveBg = Color(0xFFEEF2FF);

  static const Color statIconBg1 = Color(0xFFEEF2FF);
  static const Color statIcon1 = Color(0xFF5B67F1);
  static const Color statIconBg2 = Color(0xFFF5F3FF);
  static const Color statIcon2 = Color(0xFF805AD5);
  static const Color statIconBg3 = Color(0xFFEBF8FF);
  static const Color statIcon3 = Color(0xFF2C5282);

  static const Color logoutBg = Color(0xFFFFEBEE);

  static const BoxShadow softShadow = BoxShadow(
    color: Color(0x0A000000),
    blurRadius: 12,
    offset: Offset(0, 4),
  );

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  static const List<Color> balanceCardGradient = [Color(0xFF7585FF), Color(0xFF90A1FF)];
  static Color balanceCardShadow = const Color(0xFF7585FF).withOpacity(0.35);

  static const Color statIconBgOrange = Color(0xFFFEEBC8);
  static const Color statIconOrange = Color(0xFFED8936);
}

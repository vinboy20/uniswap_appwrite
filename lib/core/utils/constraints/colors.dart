import 'package:flutter/material.dart';

class TColors{
  TColors._();

  //app basic colors
  static const Color primary = Color(0xFF42D8B9);
  static const Color secondary = Color(0xFFFFE24B);
  static const Color accent = Color(0xFFb0c7ff);

  //Gradient colors
  static const Gradient linearGradient = LinearGradient(
    begin: Alignment(0.0, 0.0),
      end: Alignment(0.707, -0.707),
      colors: [
    Color(0xffff9a9e),
    Color(0xfffad0c4),
    Color(0xfffad0c4),
  ]);

  //text colors
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF6C757D);
  static const Color textWhite = Colors.white;

  //Background colors
  static const Color light = Color(0xFFF6F6F6);
  static const Color dark = Color(0xFF334155);
  static const Color primaryBackground = Color(0xFFF3F5FF);

  //Background container colors
  static const Color lightContainer = Color(0xFFF6F6F6);
  static  Color darkContainer = TColors.white.withOpacity(0.1);

  //Button colors
  static const Color buttonPrimary = Color(0xFF42D8B9);
  static const Color buttonSecondary = Color(0xFF6C757D);
  static const Color buttonDisabled = Color(0xFFC4C4C4);

  //Border colors
  static const Color borderPrimary = Color(0xFF42D8B9);
  static const Color borderSecondary = Color(0xFFE6E6E6);

  //Error and validation colors
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFF57C00);
  static const Color info = Color(0xFF1976D2);
  static const Color pink = Color(0XFFFA647A);

  //Neutral shades
  static const Color black = Color(0xFF232323);
  static const Color transparent = Colors.transparent;
  static const Color darkerGrey = Color(0xFF4F4F4F);
  static const Color darkGrey = Color(0xFF939393);
  static const Color grey = Color(0xFFE0E0E0);
  static const Color softGrey = Color(0xFFF8FAFC);
  static const Color lightGrey = Color(0xFFF9F9F9);
  static const Color white = Color(0xFFFFFFFF);
  static const Color cyan = Color(0XFFDFFFF8);
  static const Color blue = Color(0XFF3FA2F7);

  // Gray
  static const Color gray100 = Color(0XFFD9D9D9);
  static const Color gray50 = Color(0XFFF1F5F9);
  static const Color gray200 = Color(0XFF94A3B8);
  static const Color gray300 = Color(0XFFE2E8F0);
}
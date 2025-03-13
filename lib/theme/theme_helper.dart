import 'package:flutter/material.dart';
import '../../core/app_export.dart';

String _appTheme = "primary";

/// Helper class for managing themes and colors.
class ThemeHelper {
  // A map of custom color themes supported by the app
  final Map<String, PrimaryColors> _supportedCustomColor = {'primary': PrimaryColors()};

// A map of color schemes supported by the app
  final Map<String, ColorScheme> _supportedColorScheme = {'primary': ColorSchemes.primaryColorScheme};

  /// Changes the app theme to [newTheme].
  void changeTheme(String newTheme) {
    _appTheme = newTheme;
  }

  /// Returns the primary colors for the current theme.
  PrimaryColors _getThemeColors() {
    //throw exception to notify given theme is not found or not generated by the generator
    if (!_supportedCustomColor.containsKey(_appTheme)) {
      throw Exception("$_appTheme is not found.Make sure you have added this theme class in JSON Try running flutter pub run build_runner");
    }
    //return theme from map

    return _supportedCustomColor[_appTheme] ?? PrimaryColors();
  }

  /// Returns the current theme data.
  ThemeData _getThemeData() {
    //throw exception to notify given theme is not found or not generated by the generator
    if (!_supportedColorScheme.containsKey(_appTheme)) {
      throw Exception("$_appTheme is not found.Make sure you have added this theme class in JSON Try running flutter pub run build_runner");
    }
    //return theme from map

    var colorScheme = _supportedColorScheme[_appTheme] ?? ColorSchemes.primaryColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      // textTheme: TextThemes.textTheme(colorScheme),
      scaffoldBackgroundColor: Colors.white,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.h),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          side: BorderSide(
            color: colorScheme.primary,
            width: 1.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.h),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return colorScheme.onSurface;
        }),
        visualDensity: const VisualDensity(
          vertical: -4,
          horizontal: -4,
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }

          return colorScheme.onSurface;
        }),
        side: const BorderSide(
          width: 0,
          color: Colors.transparent,
        ),
      ),
      dividerTheme: DividerThemeData(
        thickness: 1,
        space: 1,
        color: appTheme.blueGray100,
      ),
    );
  }

  /// Returns the primary colors for the current theme.
  PrimaryColors themeColor() => _getThemeColors();

  /// Returns the current theme data.
  ThemeData themeData() => _getThemeData();
}

/// Class containing the supported text theme styles.
class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        bodyLarge: TextStyle(
          color: colorScheme.onError,
          fontSize: 16.sp,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          color: colorScheme.onSecondaryContainer,
          fontSize: 14.sp,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
        bodySmall: TextStyle(
          color: colorScheme.onError,
          fontSize: 12.sp,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
        displaySmall: TextStyle(
          color: colorScheme.onSecondaryContainer,
          fontSize: 36.sp,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
        headlineLarge: TextStyle(
          color: appTheme.gray90001,
          fontSize: 30.sp,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: TextStyle(
          color: appTheme.gray90001,
          fontSize: 24.sp,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
        labelLarge: TextStyle(
          color: colorScheme.onSecondaryContainer,
          fontSize: 12.sp,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
        labelMedium: TextStyle(
          color: appTheme.pink600,
          fontSize: 10.sp,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
        labelSmall: TextStyle(
          color: colorScheme.onSecondaryContainer,
          fontSize: 8.sp,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          color: colorScheme.onSecondaryContainer,
          fontSize: 20.sp,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
        ),
        titleMedium: TextStyle(
          color: colorScheme.onSecondaryContainer,
          fontSize: 16.sp,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
        titleSmall: TextStyle(
          color: colorScheme.onSecondaryContainer,
          fontSize: 14.sp,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
      );
}

/// Class containing the supported color schemes.
class ColorSchemes {
  static const primaryColorScheme = ColorScheme.light(
    // Primary colors
    primary: Color(0XFF41D7B9),
    primaryContainer: Color(0XFFFF0000),
    secondaryContainer: Color(0XFFB1BCCF),

    // Error colors
    errorContainer: Color(0XFF048268),
    onError: Color(0XFF94A3B8),
    onErrorContainer: Color(0XFF0000FF),

    // On colors(text colors)
    onPrimary: Color(0XFF19191B),
    onPrimaryContainer: Color(0X51FFFFFF),
    onSecondaryContainer: Color(0XFF1E293B),
  );
}

/// Class containing custom colors for a primary theme.
class PrimaryColors {
  // Amber
  Color get amber700 => const Color(0XFFF59E0B);

  // Black
  Color get black900 => const Color(0XFF000000);

  // Blue
  Color get blue400 => const Color(0XFF3FA2F7);
  Color get blueA40019 => const Color(0X191877F2);

  // BlueGray
  Color get blueGray100 => const Color(0XFFCBD5E1);
  Color get blueGray10001 => const Color(0XFFD9D9D9);
  Color get blueGray50 => const Color(0XFFECF0F4);
  Color get blueGray300 => const Color(0XFF94A3B8);
  Color get blueGray500 => const Color(0XFF64748B);
  Color get blueGray5001 => const Color(0XFFEAEFF5);
  Color get blueGray700 => const Color(0XFF475569);
  Color get blueGray70001 => const Color(0XFF4E5665);
  Color get blueGray800 => const Color(0XFF334155);

  // Cyan
  Color get cyan100 => const Color(0XFFC4FBF0);
  Color get cyan200 => const Color(0XFF7BF2DA);
  Color get cyan300 => const Color(0XFF5DE3D0);
  Color get cyan50 => const Color(0XFFDFFFF8);

  // DeepOrange
  Color get deepOrangeA400 => const Color(0XFFFF2D00);

  // Gray
  Color get gray100 => const Color(0XFFF2FAF9);
  Color get gray10001 => const Color(0XFFF5F4F4);
  Color get gray10002 => const Color(0XFFF1F5F9);
  Color get gray50 => const Color(0XFFF8FAFC);
  Color get gray5001 => const Color(0XFFEFFFFC);
  Color get gray700 => const Color(0XFF595B5E);
  Color get gray800 => const Color(0XFF373943);
  Color get gray900 => const Color(0XFF18191A);
  Color get gray90001 => const Color(0XFF0F172A);

  // Grayf
  Color get gray6003f => const Color(0X3F746D6D);

  // Green
  Color get green400 => const Color(0XFF56C568);
  Color get green50 => const Color(0XFFE4FFF0);
  Color get green900 => const Color(0XFF008000);

  // Indigo
  Color get indigo50 => const Color(0XFFE2E8F0);

  // LightBluef
  Color get lightBlue7004f => const Color(0X4F0079D1);

  // LightGreene
  Color get lightGreen3001e => const Color(0X1ECAB772);

  // Orange
  Color get orange800 => const Color(0XFFD97706);

  // OrangeAf
  Color get orangeA7004f => const Color(0X4FF85F09);

  // Pink
  Color get pink300 => const Color(0XFFFA647A);
  Color get pink40019 => const Color(0X19D03B9A);
  Color get pink600 => const Color(0XFFE11D48);

  // Red
  Color get red100 => const Color(0XFFFFD6DC);
  Color get red400 => const Color(0XFFEB5757);

  // Teal
  Color get teal300 => const Color(0XFF41D4B5);
  Color get teal30001 => const Color(0XFF42D8B9);
  Color get teal400 => const Color(0XFF1CBE9C);
  Color get teal500 => const Color(0XFF0E9F81);
  Color get tealA100 => const Color(0XFF98F9E6);
  Color get tealA400 => const Color(0XFF2DD4BF);
}

PrimaryColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();

import 'package:flutter/material.dart';
import 'package:uniswap/core/app_export.dart';

class TAppDecoration {
  // Fill decorations
  static BoxDecoration get darkGrey => const BoxDecoration(
        color: Color(0xFFE2E8F0),
      );
  static BoxDecoration get boxWhite => const BoxDecoration(
        color: Color(0xFFFFFFFF),
      );

static BoxDecoration get fillBlueGray => BoxDecoration(
        color: appTheme.blueGray700,
      );
  static BoxDecoration get outlineBlack => const BoxDecoration(
        color: TColors.gray50,
        boxShadow: [
          BoxShadow(
            color: TColors.softGrey,
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(
              0,
              1,
            ),
          ),
        ],
      );
  static BoxDecoration get fillBluegray50 => BoxDecoration(
        color: TColors.gray50.withOpacity(0.58),
      );
  static BoxDecoration get fillCyan => BoxDecoration(
        color: appTheme.cyan200,
      );
  static BoxDecoration get fillCyan50 => BoxDecoration(
    color: appTheme.cyan50,
  );
  static BoxDecoration get fillGray => const BoxDecoration(
        color: TColors.gray50,
        // color: appTheme.gray10002,
      );
  static BoxDecoration get fillGray50 => const BoxDecoration(
        color: TColors.gray50,
      );
  static BoxDecoration get fillGray501 => BoxDecoration(
        color: appTheme.gray50.withOpacity(0.7),
      );
  static BoxDecoration get fillGreen => const BoxDecoration(
        // color: appTheme.green900,
        color: TColors.gray50,
      );
   static BoxDecoration get outlineCyan1001 => BoxDecoration(
        color: appTheme.gray5001,
        border: Border.all(
          color: appTheme.cyan100,
          width: 1.h,
        ),
      );
  static BoxDecoration get fillIndigo => const BoxDecoration(
        // color: appTheme.indigo50,
        color: TColors.gray50,
      );
  static BoxDecoration get whiteBox => const BoxDecoration(
        color: TColors.white,
      );
  static BoxDecoration get fillOnPrimaryContainer => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
      );
  static BoxDecoration get fillPrimary => BoxDecoration(
        color: theme.colorScheme.primary,
      );
  static BoxDecoration get fillPrimaryContainer => BoxDecoration(
        color: theme.colorScheme.primaryContainer,
      );
  static BoxDecoration get fillRed => BoxDecoration(
        color: appTheme.red100,
      );
  static BoxDecoration get fillTeal => BoxDecoration(
        color: appTheme.teal30001.withOpacity(0.42),
      );
  static BoxDecoration get fillTeal30001 => BoxDecoration(
        color: appTheme.teal30001.withOpacity(0.6),
      );
  static BoxDecoration get fillTeal300011 => BoxDecoration(
        color: appTheme.teal30001,
      );

  // Gradient decorations
  static BoxDecoration get gradientBlackToBlack => BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0.5, -0.04),
          end: const Alignment(0.5, 1),
          colors: [
            appTheme.black900.withOpacity(0.5),
            appTheme.black900.withOpacity(0.5),
          ],
        ),
      );
  static BoxDecoration get gradientBlackToBlack900 => BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0.5, -0.04),
          end: const Alignment(0.5, 1),
          colors: [
            appTheme.black900.withOpacity(0.2),
            appTheme.black900.withOpacity(0.2),
          ],
        ),
      );
  // static BoxDecoration get gradientGrayToGray => BoxDecoration(
  //       gradient: LinearGradient(
  //         begin: const Alignment(0.77, 0.17),
  //         end: const Alignment(0.5, 1),
  //         colors: [
  //           appTheme.gray10002.withOpacity(0.6),
  //           appTheme.gray10002.withOpacity(0.6),
  //         ],
  //       ),
  //     );
  // static BoxDecoration get gradientGrayToGray10002 => BoxDecoration(
  //       gradient: LinearGradient(
  //         begin: const Alignment(0.77, 0.17),
  //         end: const Alignment(0.5, 1),
  //         colors: [
  //           appTheme.gray10002.withOpacity(0.22),
  //           appTheme.gray10002.withOpacity(0.87),
  //         ],
  //       ),
  //     );
  // static BoxDecoration get gradientGrayToGray100021 => BoxDecoration(
  //       gradient: LinearGradient(
  //         begin: const Alignment(0.77, 0.17),
  //         end: const Alignment(0.5, 1),
  //         colors: [
  //           appTheme.gray10002.withOpacity(0.22),
  //           appTheme.gray10002.withOpacity(0.87),
  //         ],
  //       ),
  //     );

  // // Homepage decorations
  // static BoxDecoration get homepage => BoxDecoration(
  //       color: appTheme.blueGray50,
  //       boxShadow: [
  //         BoxShadow(
  //           color: appTheme.black900.withOpacity(0.04),
  //           spreadRadius: 2,
  //           blurRadius: 2,
  //           offset: const Offset(
  //             0,
  //             10,
  //           ),
  //         ),
  //       ],
  //     );

  // Linear decorations
  static BoxDecoration get linear => BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0.75, 0.21),
          end: const Alignment(0.01, 0.57),
          colors: [
            TColors.primary,
            TColors.cyan.withOpacity(0.72),
          ],
        ),
      );

  static ButtonStyle get softDark => OutlinedButton.styleFrom(
        backgroundColor: TColors.dark,
        side: const BorderSide(
          color: TColors.primary,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.h),
        ),
      );
  static ButtonStyle get white => OutlinedButton.styleFrom(
        backgroundColor: TColors.white,
        side: const BorderSide(
          color: TColors.primary,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.h),
        ),
      );
  // // Outline decorations
  // static BoxDecoration get outlineBlack => BoxDecoration(
  //       color: appTheme.gray10002,
  //       boxShadow: [
  //         BoxShadow(
  //           color: appTheme.black900.withOpacity(0.06),
  //           spreadRadius: 2,
  //           blurRadius: 2,
  //           offset: const Offset(
  //             0,
  //             1,
  //           ),
  //         ),
  //       ],
  //     );
  // static BoxDecoration get outlineBlack900 => BoxDecoration(
  //       color: appTheme.gray10002,
  //       boxShadow: [
  //         BoxShadow(
  //           color: appTheme.black900.withOpacity(0.04),
  //           spreadRadius: 2,
  //           blurRadius: 2,
  //           offset: const Offset(
  //             0,
  //             10,
  //           ),
  //         ),
  //       ],
  //     );
  // static BoxDecoration get outlineBlack9001 => BoxDecoration(
  //       color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
  //       boxShadow: [
  //         BoxShadow(
  //           color: appTheme.black900.withOpacity(0.06),
  //           spreadRadius: 2,
  //           blurRadius: 2,
  //           offset: const Offset(
  //             0,
  //             1,
  //           ),
  //         ),
  //       ],
  //     );
  // static BoxDecoration get outlineBlack9002 => BoxDecoration(
  //       color: appTheme.tealA100.withOpacity(0.31),
  //       boxShadow: [
  //         BoxShadow(
  //           color: appTheme.black900.withOpacity(0.04),
  //           spreadRadius: 2,
  //           blurRadius: 2,
  //           offset: const Offset(
  //             0,
  //             13.17,
  //           ),
  //         ),
  //       ],
  //     );
  // static BoxDecoration get outlineBlack9003 => BoxDecoration(
  //       color: appTheme.cyan50,
  //       boxShadow: [
  //         BoxShadow(
  //           color: appTheme.black900.withOpacity(0.04),
  //           spreadRadius: 2,
  //           blurRadius: 2,
  //           offset: const Offset(
  //             0,
  //             10,
  //           ),
  //         ),
  //       ],
  //     );
  // static BoxDecoration get outlineBlack9004 => BoxDecoration(
  //       color: appTheme.gray50,
  //       boxShadow: [
  //         BoxShadow(
  //           color: appTheme.black900.withOpacity(0.04),
  //           spreadRadius: 2,
  //           blurRadius: 2,
  //           offset: const Offset(
  //             0,
  //             10,
  //           ),
  //         ),
  //       ],
  //     );
  // static BoxDecoration get outlineBlack9005 => const BoxDecoration();
  // static BoxDecoration get outlineBlack9006 => BoxDecoration(
  //       color: appTheme.gray50,
  //       boxShadow: [
  //         BoxShadow(
  //           color: appTheme.black900.withOpacity(0.1),
  //           spreadRadius: 2,
  //           blurRadius: 2,
  //           offset: const Offset(
  //             0,
  //             -4,
  //           ),
  //         ),
  //       ],
  //     );
  static BoxDecoration get outlineBlack9007 => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.04),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(
              0,
              10,
            ),
          ),
        ],
      );
  // static BoxDecoration get outlineBlack9008 => BoxDecoration(
  //       color: appTheme.gray10002,
  //       boxShadow: [
  //         BoxShadow(
  //           color: appTheme.black900.withOpacity(0.06),
  //           spreadRadius: 2,
  //           blurRadius: 2,
  //           offset: const Offset(
  //             0,
  //             1,
  //           ),
  //         ),
  //       ],
  //     );
  // static BoxDecoration get outlineBlack9009 => BoxDecoration(
  //       color: appTheme.gray10002,
  //       border: Border.all(
  //         color: appTheme.black900,
  //         width: 1,
  //       ),
  //     );
  // static BoxDecoration get outlineBlueGray => const BoxDecoration();
  // static BoxDecoration get outlineBluegray100 => BoxDecoration(
  //       border: Border(
  //         bottom: BorderSide(
  //           color: appTheme.blueGray100,
  //           width: 1,
  //         ),
  //       ),
  //     );
  // static BoxDecoration get outlineBluegray1001 => BoxDecoration(
  //       border: Border(
  //         top: BorderSide(
  //           color: appTheme.blueGray100,
  //           width: 1,
  //         ),
  //         bottom: BorderSide(
  //           color: appTheme.blueGray100,
  //           width: 1,
  //         ),
  //       ),
  //     );
  // static BoxDecoration get outlineBluegray1002 => BoxDecoration(
  //       border: Border(
  //         bottom: BorderSide(
  //           color: appTheme.blueGray100,
  //           width: 1,
  //         ),
  //       ),
  //     );
  static BoxDecoration get outlineCyan => BoxDecoration(
        border: Border.all(
          color: appTheme.cyan200,
          width: 1,
        ),
      );
  // static BoxDecoration get outlineCyan100 => BoxDecoration(
  //       border: Border.all(
  //         color: appTheme.cyan100,
  //         width: 1,
  //       ),
  //     );
  static BoxDecoration get outlineCyan100 => BoxDecoration(
        color: appTheme.gray5001,
        border: Border.all(
          color: appTheme.cyan100,
          width: 1,
        ),
      );
  // static BoxDecoration get outlineGray6003f => BoxDecoration(
  //       color: theme.colorScheme.onPrimaryContainer,
  //       boxShadow: [
  //         BoxShadow(
  //           color: appTheme.gray6003f,
  //           spreadRadius: 2,
  //           blurRadius: 2,
  //           offset: const Offset(
  //             0,
  //             25,
  //           ),
  //         ),
  //       ],
  //     );
  // static BoxDecoration get outlineGray6003f1 => BoxDecoration(
  //       color: appTheme.indigo50.withOpacity(0.42),
  //       boxShadow: [
  //         BoxShadow(
  //           color: appTheme.gray6003f,
  //           spreadRadius: 2,
  //           blurRadius: 2,
  //           offset: const Offset(
  //             0,
  //             69.92,
  //           ),
  //         ),
  //       ],
  //     );
  // static BoxDecoration get outlineGrayF => BoxDecoration(
  //       color: appTheme.indigo50,
  //       boxShadow: [
  //         BoxShadow(
  //           color: appTheme.gray6003f,
  //           spreadRadius: 2,
  //           blurRadius: 2,
  //           offset: const Offset(
  //             0,
  //             19.74,
  //           ),
  //         ),
  //       ],
  //     );
  // static BoxDecoration get decorationShadow => BoxDecoration(
  //       color: appTheme.indigo50,
  //       boxShadow: [
  //         BoxShadow(
  //           color: appTheme.gray6003f,
  //           spreadRadius: 2,
  //           blurRadius: 29,
  //           offset: const Offset(
  //             0,
  //             19.74,
  //           ),
  //         ),
  //       ],
  //     );
  // static BoxDecoration get outlineOnError => BoxDecoration(
  //       color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
  //       border: Border.all(
  //         color: theme.colorScheme.onError,
  //         width: 1,
  //       ),
  //     );
  // static BoxDecoration get outlinePrimary => BoxDecoration(
  //       border: Border.all(
  //         color: theme.colorScheme.primary,
  //         width: 1,
  //       ),
  //     );
  // static BoxDecoration get outlineTeal => BoxDecoration(
  //       color: appTheme.gray50,
  //     );
  // static BoxDecoration get outlineTeal30001 => BoxDecoration(
  //       border: Border.all(
  //         color: appTheme.teal30001,
  //         width: 1,
  //       ),
  //     );

  // Row decorations
  static BoxDecoration get row36 => const BoxDecoration();
}

class BorderRadiusStyle {
  // Circle borders
  static BorderRadius get circleBorder117 => BorderRadius.circular(
        117,
      );
  static BorderRadius get circleBorder19 => BorderRadius.circular(
        19,
      );
  static BorderRadius get circleBorder28 => BorderRadius.circular(
        28,
      );
  static BorderRadius get circleBorder36 => BorderRadius.circular(
        36,
      );
  static BorderRadius get circleBorder40 => BorderRadius.circular(
        40,
      );
  static BorderRadius get circleBorder90 => BorderRadius.circular(
        90,
      );
  static BorderRadius get circleBorder96 => BorderRadius.circular(
        96,
      );

  // Custom borders
  static BorderRadius get customBorderBL10 => const BorderRadius.vertical(
        bottom: Radius.circular(10),
      );
  static BorderRadius get customBorderBL101 => const BorderRadius.only(
        topRight: Radius.circular(10),
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
      );
  static BorderRadius get customBorderBL16 => const BorderRadius.vertical(
        bottom: Radius.circular(16),
      );
  static BorderRadius get customBorderTL10 => const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
        bottomLeft: Radius.circular(6),
        bottomRight: Radius.circular(6),
      );
  static BorderRadius get customBorderTL101 => const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
        bottomLeft: Radius.circular(10),
      );
  static BorderRadius get customBorderTL20 => const BorderRadius.only(
        topLeft: Radius.circular(20),
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      );
  static BorderRadius get customBorderTL28 => const BorderRadius.only(
        topLeft: Radius.circular(28),
        topRight: Radius.circular(28),
        bottomLeft: Radius.circular(8),
        bottomRight: Radius.circular(8),
      );
  static BorderRadius get customBorderTL40 => const BorderRadius.vertical(
        top: Radius.circular(40),
      );
  static BorderRadius get customBorderTL8 => const BorderRadius.vertical(
        top: Radius.circular(8),
      );

  // Rounded borders
  static BorderRadius get roundedBorder10 => BorderRadius.circular(
        10,
      );
  static BorderRadius get roundedBorder15 => BorderRadius.circular(
        15,
      );
  static BorderRadius get roundedBorder22 => BorderRadius.circular(
        22,
      );
  static BorderRadius get roundedBorder25 => BorderRadius.circular(
        25,
      );
  static BorderRadius get roundedBorder3 => BorderRadius.circular(
        3,
      );
  static BorderRadius get roundedBorder47 => BorderRadius.circular(
        47,
      );
  static BorderRadius get roundedBorder50 => BorderRadius.circular(
        50,
      );
  static BorderRadius get roundedBorder6 => BorderRadius.circular(
        6,
      );
}

// Comment/Uncomment the below code based on your Flutter SDK version.

// For Flutter SDK Version 3.7.2 or greater.

double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;

// For Flutter SDK Version 3.7.1 or less.

// StrokeAlign get strokeAlignInside => StrokeAlign.inside;
//
// StrokeAlign get strokeAlignCenter => StrokeAlign.center;
//
// StrokeAlign get strokeAlignOutside => StrokeAlign.outside;
    
import 'package:flutter/material.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/core/utils/constraints/colors.dart';
import 'package:uniswap/core/utils/constraints/sizes.dart';
import 'package:uniswap/theme/theme_helper.dart';

class CustomTextStyles {
  static TextStyle text20bold = TextStyle(
    fontSize: TSizes.fontSizexl,
    fontWeight: FontWeight.bold,
    color: TColors.textPrimary,
  );

  static get labelLargefff1f5f9 => theme.textTheme.labelLarge!.copyWith(
        color: const Color(0XFFF1F5F9),
        fontWeight: FontWeight.w700,
      );

  static get bodySmallfff1f5f9 => theme.textTheme.bodySmall!.copyWith(
        color: const Color(0XFFF1F5F9),
      );

  static get bodySmallGray10002 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray10002,
      );

  static get titleMediumOnPrimaryContainer => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
      );

  static get titleMediumBlack900 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900,
      );

  static get labelLargeGray10002 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.gray10002,
      );

  static get titleMediumGray900 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray900,
      );

       static get titleMediumGray90018 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray900,
        fontSize: 18.sp,
      );

  static TextStyle text14w400 = TextStyle(
    fontSize: TSizes.fontSizeSm,
    fontFamily: "Inter",
    fontWeight: FontWeight.w400,
    color: const Color(0xFF334155),
  );

  static TextStyle text14wbold = TextStyle(
    fontSize: TSizes.fontSizeSm,
    fontFamily: "Inter",
    fontWeight: FontWeight.w600,
    color: const Color(0xFF334155),
  );

  static TextStyle text14wboldc19 = TextStyle(
    fontSize: TSizes.fontSizeSm,
    fontFamily: "Inter",
    fontWeight: FontWeight.w600,
    color: const Color(0xFF19191B),
  );

  static TextStyle text12w400 = TextStyle(
    fontSize: TSizes.fontSizeXs,
    fontFamily: "Inter",
    fontWeight: FontWeight.w400,
    color: const Color(0xFF334155),
  );

  static TextStyle text12w700 = TextStyle(
    fontSize: TSizes.fontSizeXs,
    fontFamily: "Inter",
    fontWeight: FontWeight.w700,
    color: const Color(0xFF94A3B8),
  );

  static TextStyle text12w400cF1 = TextStyle(
    fontSize: TSizes.fontSizeXs,
    fontFamily: "Inter",
    fontWeight: FontWeight.w400,
    color: const Color(0xFFF1F5F9),
  );

  static TextStyle text14w400cF1 = TextStyle(
    fontSize: TSizes.fontSizeSm,
    fontFamily: "Inter",
    fontWeight: FontWeight.w700,
    color: const Color(0xFFF1F5F9),
  );

  static TextStyle text14w600c0F = TextStyle(
    fontSize: TSizes.fontSizeSm,
    fontFamily: "Inter",
    fontWeight: FontWeight.w600,
    color: const Color(0xFF0F172A),
  );
  static TextStyle text12w600c0F = TextStyle(
    fontSize: TSizes.fontSizeXs,
    fontFamily: "Inter",
    fontWeight: FontWeight.w600,
    color: const Color(0xFF0F172A),
  );

  static TextStyle text12w400cPrimary = TextStyle(
    fontSize: TSizes.fontSizeXs,
    fontFamily: "Inter",
    fontWeight: FontWeight.w400,
    color: TColors.primary,
  );
  static TextStyle text12wBold = TextStyle(
    fontSize: TSizes.fontSizeXs,
    fontFamily: "Inter",
    fontWeight: FontWeight.bold,
    color: TColors.textPrimary,
  );

  static TextStyle text12w400cpink = TextStyle(
    fontSize: TSizes.fontSizeXs,
    fontFamily: "Inter",
    fontWeight: FontWeight.w400,
    color: TColors.pink,
  );

  static TextStyle text14w400cPrimary = TextStyle(
    fontSize: TSizes.fontSizeSm,
    fontFamily: "Inter",
    fontWeight: FontWeight.w400,
    color: TColors.primary,
  );
  static TextStyle text14wboldcPrimary = TextStyle(
    fontSize: TSizes.fontSizeSm,
    fontFamily: "Inter",
    fontWeight: FontWeight.w600,
    color: TColors.primary,
  );
  static TextStyle text14w600cPrimary = TextStyle(
    fontSize: TSizes.fontSizeSm,
    fontFamily: "Inter",
    fontWeight: FontWeight.w600,
    color: TColors.textPrimary,
  );

  static TextStyle text16w400 = TextStyle(
    fontSize: TSizes.fontSizeMd,
    fontFamily: "Inter",
    fontWeight: FontWeight.w400,
    color: const Color(0xFF334155),
  );

  static TextStyle text16Bold = TextStyle(
      fontSize: TSizes.fontSizeMd,
      fontFamily: "inter",
      fontWeight: FontWeight.bold,
      // color: const Color(0xFF334155),
      color: TColors.textPrimary);

  static TextStyle text16b600cF1 = TextStyle(
    fontSize: TSizes.fontSizeMd,
    fontFamily: "inter",
    fontWeight: FontWeight.w600,
    color: Color(0xFFF1F5F9),
  );

  static TextStyle text18BoldcPrimary = TextStyle(
    fontSize: TSizes.fontSizeLg,
    fontFamily: "Inter",
    fontWeight: FontWeight.w700,
    color: TColors.primary,
  );
  static TextStyle text18w600cPrimary = TextStyle(
    fontSize: TSizes.fontSizeLg,
    fontFamily: "Inter",
    fontWeight: FontWeight.w600,
    color: TColors.primary,
  );
  static TextStyle text18w600c33 = TextStyle(
    fontSize: TSizes.fontSizeLg,
    fontFamily: "Inter",
    fontWeight: FontWeight.w600,
    color: Color(0xFF334155),
  );

  static TextStyle text24w600cmain = TextStyle(
    fontSize: TSizes.fontSize2xl,
    fontFamily: "Inter",
    fontWeight: FontWeight.w600,
    color: TColors.textPrimary,
  );

  static TextStyle text14w400cBlue = TextStyle(
    fontSize: TSizes.fontSizeSm,
    fontFamily: "Inter",
    fontWeight: FontWeight.w400,
    color: const Color(0xFF3FA2F7),
  );

  static TextStyle button = TextStyle(
    fontSize: TSizes.fontSizeLg,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}

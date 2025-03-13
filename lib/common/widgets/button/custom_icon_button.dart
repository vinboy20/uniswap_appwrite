import 'package:flutter/material.dart';
import 'package:uniswap/core/app_export.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    this.alignment,
    this.height,
    this.width,
    this.padding,
    this.decoration,
    this.child,
    this.onTap,
  });

  final Alignment? alignment;

  final double? height;

  final double? width;

  final EdgeInsetsGeometry? padding;

  final Decoration? decoration;

  final Widget? child;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: iconButtonWidget,
          )
        : iconButtonWidget;
  }

  Widget get iconButtonWidget => SizedBox(
        height: height ?? 0,
        width: width ?? 0,
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: Container(
            height: height ?? 0,
            width: width ?? 0,
            padding: padding ?? EdgeInsets.zero,
            decoration: decoration ??
                const BoxDecoration(
                    // color: appTheme.blueGray700,
                    // borderRadius: BorderRadius.circular(15.h),
                    ),
            child: child,
          ),
          onPressed: onTap,
        ),
      );
}

/// Extension on [CustomIconButton] to facilitate inclusion of all types of border style etc
extension IconButtonStyleHelper on CustomIconButton {
  static BoxDecoration get fillCyan => BoxDecoration(
    color: TColors.primary.withOpacity(0.15),
    borderRadius: BorderRadius.circular(26.w),
  );
  static BoxDecoration get primary => BoxDecoration(
    color: TColors.primary.withOpacity(0.15),
    borderRadius: BorderRadius.circular(50.w),
  );
  static BoxDecoration get outlineGrayF => BoxDecoration(
        color: TColors.black,
        borderRadius: BorderRadius.circular(25.w),
        boxShadow: [
          BoxShadow(
            color: TColors.gray50,
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: const Offset(
              0,
              25,
            ),
          ),
        ],
      );
  static BoxDecoration get outlineIndigo => BoxDecoration(
        color: TColors.gray100,
        borderRadius: BorderRadius.circular(18.w),
        border: Border.all(
          color: TColors.accent,
          width: 1.h,
        ),
      );
  static BoxDecoration get fillTeal => BoxDecoration(
        color: TColors.primary.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10.w),
      );
  static BoxDecoration get fillBlueGray => BoxDecoration(
        color: TColors.gray200,
        borderRadius: BorderRadius.circular(12.w),
      );
  static BoxDecoration get softGray => BoxDecoration(
        color: TColors.softGrey,
        borderRadius: BorderRadius.circular(50.w),
      );
  static BoxDecoration get outlineIndigoTL22 => BoxDecoration(
        color: TColors.cyan,
        borderRadius: BorderRadius.circular(22.w),
        border: Border.all(
          color: TColors.accent,
          width: 1.h,
        ),
      );
  static BoxDecoration get fillIndigo => BoxDecoration(
        color: TColors.accent,
        borderRadius: BorderRadius.circular(17.w),
      );
  static BoxDecoration get fillGray => BoxDecoration(
        color: TColors.gray50,
        borderRadius: BorderRadius.circular(6.w),
      );
  static BoxDecoration get fillBlueGrayTL17 => BoxDecoration(
        color: TColors.darkGrey,
        borderRadius: BorderRadius.circular(17.w),
      );
  static BoxDecoration get outlineBlack => BoxDecoration(
        color: TColors.accent,
        borderRadius: BorderRadius.circular(19.w),
        boxShadow: [
          BoxShadow(
            color: TColors.black.withOpacity(0.04),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: const Offset(
              0,
              10,
            ),
          ),
        ],
      );
  static BoxDecoration get fillBlueA => BoxDecoration(
        color: TColors.darkGrey,
        borderRadius: BorderRadius.circular(26.w),
      );
  static BoxDecoration get fillPink => BoxDecoration(
        color: TColors.info,
        borderRadius: BorderRadius.circular(26.w),
      );
  static BoxDecoration get fillBlueGrayTL26 => BoxDecoration(
        color: TColors.gray200.withOpacity(0.15),
        borderRadius: BorderRadius.circular(26.w),
      );
  static BoxDecoration get fillGrayTL46 => BoxDecoration(
        color: TColors.gray100,
        borderRadius: BorderRadius.circular(46.w),
      );
  static BoxDecoration get outlineBlackTL8 => BoxDecoration(
        color: TColors.gray50,
        borderRadius: BorderRadius.circular(8.w),
        boxShadow: [
          BoxShadow(
            color: TColors.black.withOpacity(0.06),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: const Offset(
              0,
              2,
            ),
          ),
        ],
      );
  static BoxDecoration get outlineBlueGray => BoxDecoration(
        borderRadius: BorderRadius.circular(29.h),
        border: Border.all(
          color: TColors.darkGrey,
          width: 1.h,
        ),
      );
  static BoxDecoration get outlineGray => BoxDecoration(
        borderRadius: BorderRadius.circular(29.h),
        border: Border.all(
          color: TColors.gray100,
          width: 1.h,
        ),
      );
  static BoxDecoration get fillBlueGrayTL28 => BoxDecoration(
        color: TColors.gray50,
        borderRadius: BorderRadius.circular(28.h),
      );
  static BoxDecoration get fillGray1 => const BoxDecoration(
        color: TColors.gray100,
      );
  static BoxDecoration get fillCyanTL17 => BoxDecoration(
        color: TColors.accent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            17.h,
          ),
          topRight: Radius.circular(
            16.h,
          ),
          bottomLeft: Radius.circular(
            17.h,
          ),
          bottomRight: Radius.circular(
            16.h,
          ),
        ),
      );
}

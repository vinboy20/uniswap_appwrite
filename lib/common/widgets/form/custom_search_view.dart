import 'package:flutter/material.dart';
import 'package:uniswap/core/app_export.dart';

class CustomSearchView extends StatelessWidget {
  const CustomSearchView({
    super.key,
    this.alignment,
    this.width,
    this.scrollPadding,
    this.controller,
    this.focusNode,
    this.autofocus = true,
    this.textStyle,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.filled = true,
    this.validator,
    this.onChanged,
  });

  final Alignment? alignment;

  final double? width;

  final TextEditingController? scrollPadding;

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final bool? autofocus;

  final TextStyle? textStyle;

  final TextInputType? textInputType;

  final int? maxLines;

  final String? hintText;

  final TextStyle? hintStyle;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final EdgeInsets? contentPadding;

  final InputBorder? borderDecoration;

  final Color? fillColor;

  final bool? filled;

  final FormFieldValidator<String>? validator;

  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: searchViewWidget(context),
          )
        : searchViewWidget(context);
  }

  Widget searchViewWidget(BuildContext context) => SizedBox(
        width: width ?? double.maxFinite,
        child: TextFormField(
          scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          controller: controller,
          focusNode: focusNode ?? FocusNode(),
          // autofocus: autofocus!,
          autofocus: autofocus ?? false,
          style: textStyle ?? CustomTextStyles.text14w400,
          keyboardType: textInputType,
          maxLines: maxLines ?? 1,
          decoration: decoration,
          validator: validator,
          onChanged: (String value) {
            onChanged!.call(value);
          },
        ),
      );
  InputDecoration get decoration => InputDecoration(
        hintText: hintText ?? "",
        hintStyle: hintStyle ?? CustomTextStyles.text14w400,
        prefixIcon: prefix ??
            Container(
              margin: EdgeInsets.fromLTRB(10.w, 19.h, 6.w, 17.h),
              child: const Icon(Icons.search_outlined),
            ),
        prefixIconConstraints: prefixConstraints ??
            BoxConstraints(
              maxHeight: 56.h,
            ),
        // suffixIcon: suffix ??
        //   Container(
        //     padding: EdgeInsets.all(7.w),
        //     margin: EdgeInsets.fromLTRB(30.w, 10.h, 16.w, 10.h),
        //     decoration: BoxDecoration(
        //       color: TColors.darkGrey.withOpacity(0.18),
        //       borderRadius: BorderRadius.circular(17.w),
        //     ),
        //     child: CustomImageView(
        //       imagePath: ImageConstant.imgIconOutlineFilter,
        //       height: 20.adaptSize,
        //       width: 20.adaptSize,
        //     ),
        //   ),
        suffixIconConstraints: suffixConstraints ??
            BoxConstraints(
              maxHeight: 56.h,
            ),
        isDense: true,
        contentPadding: contentPadding ?? EdgeInsets.only(top: 19.h, right: 19.w, bottom: 19.h),
        fillColor: fillColor ?? TColors.gray50,
        filled: filled,
        border: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.h),
              borderSide: const BorderSide(
                // color: TColors.darkGrey,
                color: Colors.white,
                width: 1,
              ),
            ),
        enabledBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.h),
              borderSide: const BorderSide(
                color: Colors.white,
                width: 1,
              ),
            ),
        focusedBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.h),
              borderSide: const BorderSide(
                color: TColors.darkGrey,
                width: 1,
              ),
            ),
      );
}

/// Extension on [CustomSearchView] to facilitate inclusion of all types of border style etc
extension SearchViewStyleHelper on CustomSearchView {
  static OutlineInputBorder get fillTeal => OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.h),
        borderSide: BorderSide.none,
      );
  static OutlineInputBorder get outlineOnErrorTL22 => OutlineInputBorder(
        borderRadius: BorderRadius.circular(22.h),
        borderSide: const BorderSide(
          color: TColors.darkGrey,
          width: 1,
        ),
      );
}

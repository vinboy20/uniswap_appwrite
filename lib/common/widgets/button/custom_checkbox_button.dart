import 'package:flutter/material.dart';
import 'package:uniswap/core/app_export.dart';

class CustomCheckboxButton extends StatefulWidget {
  const CustomCheckboxButton({
    super.key,
    required this.onChange,
    this.decoration,
    this.alignment,
    this.isRightCheck,
    this.iconSize,
    this.value,
    this.text,
    this.width,
    this.padding,
    this.textStyle,
    this.textAlignment,
    this.isExpandedText = false,
  });

  final BoxDecoration? decoration;

  final Alignment? alignment;

  final bool? isRightCheck;

  final double? iconSize;

  final bool? value;

  final Function(bool) onChange;

  final String? text;

  final double? width;

  final EdgeInsetsGeometry? padding;

  final TextStyle? textStyle;

  final TextAlign? textAlignment;

  final bool isExpandedText;

  @override
  State<CustomCheckboxButton> createState() => _CustomCheckboxButtonState();
}

class _CustomCheckboxButtonState extends State<CustomCheckboxButton> {
  bool _checkBoxVal = true;
  @override
  Widget build(BuildContext context) {
    return widget.alignment != null
        ? Align(
            alignment: widget.alignment ?? Alignment.center,
            child: buildCheckBoxWidget,
          )
        : buildCheckBoxWidget;
  }

  Widget get buildCheckBoxWidget => InkWell(
        onTap: () {
          //value = !(widget.value!);
          widget.onChange(widget.value!);
        },
        child: Container(
          decoration: widget.decoration,
          width: widget.width,
          child: (widget.isRightCheck ?? false) ? rightSideCheckbox : leftSideCheckbox,
        ),
      );

  Widget get leftSideCheckbox => Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: checkboxWidget,
          ),
          widget.isExpandedText ? Expanded(child: textWidget) : textWidget,
        ],
      );

  Widget get rightSideCheckbox => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.isExpandedText ? Expanded(child: textWidget) : textWidget,
          Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: checkboxWidget,
          ),
        ],
      );

  Widget get textWidget => Text(
        widget.text ?? "",
        textAlign: widget.textAlignment ?? TextAlign.center,
        style: widget.textStyle ?? CustomTextStyles.text14w400,
      );

  Widget get checkboxWidget => SizedBox(
        height: widget.iconSize,
        width: widget.iconSize,
        child: Checkbox(
          checkColor: Colors.white,
          activeColor: const Color(0xFF1DBE9D),
          fillColor: WidgetStateColor.resolveWith((states) => const Color(0xFF1DBE9D)),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          // value: value ?? false,
          // onChanged: (value) {
          //   onChange(value!);
          // },
          value: _checkBoxVal,
          onChanged: (bool? value) {
            if (value != null) {
              setState(() => _checkBoxVal = value);
            }
          },
        ),
      );
}

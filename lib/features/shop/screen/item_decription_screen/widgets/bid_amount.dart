import 'package:flutter/material.dart';
import 'package:uniswap/core/app_export.dart';

class BidAmount extends StatefulWidget {
  const BidAmount({
    super.key,
    required this.amount,
    required this.onSelected,
    this.selected = false,
    this.disabled = false, // Add a disabled state
  });

  final String amount;
  final Function(bool) onSelected; // Callback for selection state
  final bool selected; // Initial selection state
  final bool disabled; // Whether the chip is disabled

  @override
  State<BidAmount> createState() => _BidAmountState();
}

class _BidAmountState extends State<BidAmount> {
  bool _selected = false; // Local state for selection

  @override
  void initState() {
    super.initState();
    _selected = widget.selected; // Initialize local state with the provided value
  }

  @override
  void didUpdateWidget(BidAmount oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update local state if the widget's selected state changes
    if (oldWidget.selected != widget.selected) {
      setState(() {
        _selected = widget.selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawChip(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
      showCheckmark: false,
      labelPadding: EdgeInsets.zero,
      label: Text(
        widget.amount,
        style: CustomTextStyles.text12wBold.copyWith(
          color: widget.disabled ? TColors.gray200 : null, // Gray out text if disabled
        ),
      ),
      selected: _selected, // Use local state
      backgroundColor: widget.disabled ? TColors.gray100 : TColors.gray300, // Gray out background if disabled
      selectedColor: TColors.white,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(22),
      ),
      onSelected: widget.disabled
          ? null // Disable onSelected if the chip is disabled
          : (value) {
              setState(() {
                _selected = value; // Update local state
              });
              widget.onSelected(value); // Invoke the callback with the new state
            },
      tooltip: widget.disabled ? "Bid option disabled" : null, // Add a tooltip for accessibility
    );
  }
}
import 'package:flutter/material.dart';
import 'package:uniswap/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:uniswap/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:uniswap/core/app_export.dart';

class TPrimaryHeaderContainer extends StatelessWidget {
  const TPrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TCurvedEdgeWidget(
      child: Container(
        color: TColors.primary,

        /// -if ( size.infinite*: is not true in stack)error occurred -> read readme.md
        child: Stack(
          children: [
            /// -- background custom shapes
            Positioned(top: -150, right: -250, child: TCircularContainer(backgroundColor: TColors.textWhite.withOpacity(0.1))),
            Positioned(top: 100, right: -300, child: TCircularContainer(backgroundColor: TColors.textWhite.withOpacity(0.1))),
            child,
          ],
        ),
      ),
    );
  }
}

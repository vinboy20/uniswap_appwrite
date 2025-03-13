import 'package:flutter/material.dart';
import 'package:uniswap/common/widgets/loaders/shimmer.dart';
import 'package:uniswap/core/app_export.dart';

class TCategoryShimmer extends StatelessWidget {
  const TCategoryShimmer({super.key, this.itemCount = 6});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
          itemCount: itemCount,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (_, __) => SizedBox(width: TSizes.spaceBtwItems),
          itemBuilder: (_, __) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///image
                const TShimmerEffect(width: 55, height: 55, radius: 55),
                SizedBox(width: TSizes.spaceBtwItems / 2),

                ///text
                const TShimmerEffect(width: 55, height: 8),
              ],
            );
          }),
    );
  }
}

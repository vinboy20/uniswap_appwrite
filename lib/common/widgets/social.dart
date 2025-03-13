import 'package:flutter/material.dart';
import 'package:uniswap/common/widgets/images/t_circular_image.dart';
import 'package:uniswap/core/app_export.dart';

class SocialAuth extends StatelessWidget {
  const SocialAuth({super.key});

  @override
  Widget build(BuildContext context) {
   
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TCircularImage(
          image: TImages.facebook,
          imageHeight: 24,
          imageWidth: 24,
          // padding: 5,
          backgroundColor: Color.fromRGBO(120, 242, 218, 0.1),
        ),
        SizedBox(width: 20),
        TCircularImage(
          image: TImages.instagram,
          imageHeight: 24,
          imageWidth: 24,
          backgroundColor: Color.fromRGBO(120, 242, 218, 0.1),
        ),
        SizedBox(width: 20),
        TCircularImage(
          image: TImages.google,
          imageHeight: 24,
          imageWidth: 24,
          backgroundColor: Color.fromRGBO(120, 242, 218, 0.1),
        ),
        SizedBox(width: 20),
        TCircularImage(
          image: TImages.twitter,
          imageHeight: 24,
          imageWidth: 24,
          backgroundColor: Color.fromRGBO(120, 242, 218, 0.1),
        ),
      ],
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:uniswap/core/app_export.dart';

Widget carouselWidget(BuildContext context) {
   final List<String> images = [
    'assets/images/ticket.png',
    'assets/images/img.png',
    'assets/images/chair.png',
    // Add more images as needed
  ];
  int sliderIndex = 0;
  return SizedBox(
    height: 117.h,
    width: 342.w,
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider.builder(
          options: CarouselOptions(
            height: 117.h,
            initialPage: 0,
            autoPlay: true,
            reverse: false,
            pageSnapping: true,
            viewportFraction: 1.0,
            enableInfiniteScroll: false,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              sliderIndex = index;
            },
          ),
          itemCount: images.length,
          itemBuilder: (context, index, realIndex) {
            // return const CarouselItemWidget();
            return CustomImageView(
              imagePath: images[index],
              width: THelperFunctions.screenWidth(),
            );
          },
        ),
        
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 6.h,
            margin: EdgeInsets.only(bottom: 3.h),
            child: AnimatedSmoothIndicator(
              activeIndex: sliderIndex,
              count: 3,
              axisDirection: Axis.horizontal,
              effect: ScrollingDotsEffect(
                spacing: 4,
                activeDotColor: const Color(0xFF0F9F81),
                dotColor: Colors.white,
                dotHeight: 6.h,
                dotWidth: 6.w,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

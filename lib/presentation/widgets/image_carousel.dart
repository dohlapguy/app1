import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../constants/app_colors.dart';

class ImageCarousel extends StatefulWidget {
  final List<String> images;
  final double height;
  final double viewport;

  const ImageCarousel(
      {super.key,
      required this.height,
      required this.images,
      this.viewport = 1});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: widget.height,
          child: CarouselSlider.builder(
            options: CarouselOptions(
              height: widget.height,
              padEnds: false,
              viewportFraction: widget.viewport,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            itemCount: widget.images.length,
            itemBuilder: (context, index, rIndex) {
              return Image.network(
                widget.images[index],
                fit: BoxFit.contain,
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        buildCarouselIndicator(),
      ],
    );
  }

  Widget buildCarouselIndicator() => AnimatedSmoothIndicator(
        activeIndex: _currentIndex,
        count: widget.images.length,
        effect: ScrollingDotsEffect(
            dotHeight: 5,
            dotWidth: 5,
            activeDotColor: AppColors.lightBlack,
            dotColor: AppColors
                .lightGrey), // You can change the effect based on your preference
      );
}

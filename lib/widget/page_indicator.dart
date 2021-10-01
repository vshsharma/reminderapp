import 'package:flutter/cupertino.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageIndicator extends StatelessWidget {
  PageIndicator(this.controller, this.length);

  final PageController controller;
  final int length;
  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      count: length,
      effect: SwapEffect(
        dotHeight: 10,
        dotWidth: 10,
        type: SwapType.normal,
      ),
      controller: controller,
    );
  }
}

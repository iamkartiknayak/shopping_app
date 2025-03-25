import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:shopping_app/core/constants.dart';
import 'package:shopping_app/features/catalogue/data/models/product_model.dart';

class ImageIndexIndicator extends StatelessWidget {
  const ImageIndexIndicator({
    super.key,
    required this.currentIndex,
    required this.product,
  });

  final int currentIndex;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 12.0),
      child: AnimatedSmoothIndicator(
        activeIndex: currentIndex,
        count: product.images.length,
        effect: ExpandingDotsEffect(
          dotWidth: 8.0,
          dotHeight: 8.0,
          activeDotColor: kAccentColor,
        ),
      ),
    );
  }
}

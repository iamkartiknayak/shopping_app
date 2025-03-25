// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:shopping_app/core/constants.dart';
import 'package:shopping_app/features/catalogue/data/models/product_model.dart';
import 'package:shopping_app/features/product/application/image_slider_notifier.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({
    super.key,
    required this.product,
    required this.sliderNotifier,
  });

  final Product product;
  final ImageSliderNotifier sliderNotifier;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: product.images.length == 1,
      child: SizedBox(
        height: 300.0,
        child: CarouselSlider.builder(
          itemCount: product.images.length,
          options: CarouselOptions(
            autoPlay: product.images.length > 1,
            autoPlayInterval: Duration(seconds: 8),
            autoPlayAnimationDuration: Duration(milliseconds: 1000),
            autoPlayCurve: Curves.easeInOut,
            height: 300.0,
            onPageChanged: (index, reason) => sliderNotifier.updateIndex(index),
          ),
          itemBuilder: (context, index, realIndex) {
            return Image.network(
              product.images[index],
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child; // Image loaded
                return Shimmer.fromColors(
                  baseColor: kShimmerChildrenColor.withOpacity(0.6),
                  highlightColor: kShimmerChildrenColor.withOpacity(0.3),
                  child: Container(
                    color: Colors.grey,
                    height: 300.0,
                    width: 400.0,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:shopping_app/common/image_shimmer.dart';

import 'package:shopping_app/core/constants.dart';

class CatalogueItemShimmer extends StatelessWidget {
  const CatalogueItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      color: Colors.white,
      child: Column(
        children: [
          ImageShimmer(iconSize: 80.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4.0),
                ContentSkeleton(height: 22.0),
                SizedBox(height: 6.0),
                ContentSkeleton(height: 12.0, width: 90.0),
                SizedBox(height: 14.0),
                Row(
                  children: [
                    ContentSkeleton(width: 44.0),
                    SizedBox(width: 4.0),
                    ContentSkeleton(width: 50.0),
                  ],
                ),
                SizedBox(height: 6.0),
                ContentSkeleton(width: 50.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ContentSkeleton extends StatelessWidget {
  const ContentSkeleton({
    super.key,
    this.height = 16.0,
    this.width = double.infinity,
    this.borderRadius = 2,
  });

  final double height;
  final double width;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: kShimmerChildrenColor.withOpacity(0.6),
      highlightColor: kShimmerChildrenColor.withOpacity(0.3),
      period: const Duration(milliseconds: 1200),
      child: Container(
        decoration: BoxDecoration(
          color: kShimmerChildrenColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        height: height,
        width: width,
      ),
    );
  }
}

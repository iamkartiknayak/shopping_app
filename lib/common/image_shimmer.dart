// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:shopping_app/core/constants.dart';

class ImageShimmer extends StatelessWidget {
  const ImageShimmer({super.key, required this.iconSize});

  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 180.0),
      width: double.infinity,
      child: Shimmer.fromColors(
        baseColor: kShimmerChildrenColor.withOpacity(0.6),
        highlightColor: kShimmerChildrenColor.withOpacity(0.3),
        child: Icon(Icons.image, size: iconSize, color: kAccentColor),
      ),
    );
  }
}

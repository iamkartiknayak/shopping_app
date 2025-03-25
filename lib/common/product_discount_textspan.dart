import 'package:flutter/material.dart';

import 'package:shopping_app/core/constants.dart';

class ProductDiscountTextSpan extends StatelessWidget {
  const ProductDiscountTextSpan({super.key, required this.discountPercentage});

  final double discountPercentage;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        style: TextStyle(color: kAccentColor),
        children: [
          TextSpan(
            text: '$discountPercentage% ',
            style: TextStyle(fontSize: 13.0),
          ),
          TextSpan(text: 'OFF'),
        ],
      ),
    );
  }
}

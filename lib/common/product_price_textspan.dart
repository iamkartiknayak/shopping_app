import 'package:flutter/material.dart';

import 'package:shopping_app/core/constants.dart';

class ProductPriceTextSpan extends StatelessWidget {
  const ProductPriceTextSpan({
    super.key,
    required this.originalPrice,
    required this.discountedPrice,
  });

  final double originalPrice;
  final double discountedPrice;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        children: [
          TextSpan(
            text: '\$$originalPrice ',
            style: kProductOriginalPriceStyle,
          ),
          TextSpan(text: ' '),
          TextSpan(
            text: '\$${discountedPrice.toStringAsFixed(2)}',
            style: kProductDiscountedPriceStyle,
          ),
        ],
      ),
    );
  }
}

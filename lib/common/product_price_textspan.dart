import 'package:flutter/material.dart';

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
            style: TextStyle(
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
              decorationColor: Colors.grey.shade600,
              fontSize: 12.0,
            ),
          ),
          TextSpan(text: ' '),
          TextSpan(
            text: '\$${discountedPrice.toStringAsFixed(2)}',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

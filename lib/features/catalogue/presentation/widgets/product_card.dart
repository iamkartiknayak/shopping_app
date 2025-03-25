import 'package:flutter/material.dart';

import 'package:shopping_app/common/product_discount_textspan.dart';
import 'package:shopping_app/common/product_price_textspan.dart';
import 'package:shopping_app/core/constants.dart';
import 'package:shopping_app/features/catalogue/data/models/product_model.dart';
import 'package:shopping_app/features/catalogue/presentation/widgets/add_to_cart_button.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Stack(
            children: [
              Image.network(
                product.thumbnail,
                fit: BoxFit.contain,
                height: 180.0,
              ),
              AddToCartButton(onTap: () {}),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  product.title,
                  overflow: TextOverflow.ellipsis,
                  style: kProductTitleStyle,
                ),
                SizedBox(height: 2.0),
                Text(product.brand, style: TextStyle(fontSize: 12.0)),
                SizedBox(height: 10.0),
                ProductPriceTextSpan(
                  originalPrice: product.price,
                  discountedPrice: product.discountedPrice,
                ),
                SizedBox(height: 2.0),
                ProductDiscountTextSpan(
                  discountPercentage: product.discountPercentage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

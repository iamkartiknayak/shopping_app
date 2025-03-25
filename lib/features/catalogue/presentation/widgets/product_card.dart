// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import 'package:shopping_app/common/product_discount_textspan.dart';
import 'package:shopping_app/common/product_price_textspan.dart';
import 'package:shopping_app/core/constants.dart';
import 'package:shopping_app/features/cart/application/cart_notifier.dart';
import 'package:shopping_app/features/catalogue/data/models/product_model.dart';
import 'package:shopping_app/features/catalogue/presentation/widgets/add_to_cart_button.dart';
import 'package:shopping_app/features/product/presentation/product_page.dart';

class ProductCard extends ConsumerWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductPage(product: product),
            ),
          ),
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  product.thumbnail,
                  fit: BoxFit.contain,
                  height: 180.0,

                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Shimmer.fromColors(
                      period: Duration(milliseconds: 800),
                      baseColor: kShimmerChildrenColor.withOpacity(0.6),
                      highlightColor: kShimmerChildrenColor.withOpacity(0.3),
                      child: Container(color: Colors.grey, height: 180.0),
                    );
                  },
                ),
                AddToCartButton(
                  onTap: () {
                    ref.read(cartProvider.notifier).addToCart(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: 2),
                        backgroundColor: kBackgroundColor,
                        content: Text.rich(
                          TextSpan(
                            text: product.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: " added to cart!",
                                style: TextStyle(fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 4.0),
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
      ),
    );
  }
}

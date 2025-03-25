import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shopping_app/common/product_discount_textspan.dart';
import 'package:shopping_app/common/product_price_textspan.dart';
import 'package:shopping_app/core/constants.dart';
import 'package:shopping_app/features/cart/application/cart_notifier.dart';
import 'package:shopping_app/features/cart/presentation/widgets/quantity_icon_button.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);

    return Scaffold(
      backgroundColor: Color(0xFFFFEBEE),
      appBar: AppBar(title: Text("Cart"), centerTitle: true),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final product = cartItems.keys.elementAt(index);
          final quantity = cartItems[product]!;
          return Container(
            color: Colors.white,
            margin: EdgeInsets.only(bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  product.thumbnail,
                  fit: BoxFit.contain,
                  height: 160.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 12.0),
                      Text(product.title, style: kProductTitleStyle),
                      SizedBox(height: 2.0),
                      Text(product.brand, style: TextStyle(fontSize: 12.0)),
                      SizedBox(height: 8.0),
                      ProductPriceTextSpan(
                        originalPrice: product.price,
                        discountedPrice: product.discountedPrice,
                      ),
                      SizedBox(height: 4.0),
                      ProductDiscountTextSpan(
                        discountPercentage: product.discountPercentage,
                      ),
                      SizedBox(height: 14.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 36.0,
                            width: 90.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFF5F5F5),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                QuantityIconButton(
                                  icon: Icons.remove,
                                  onTap:
                                      () =>
                                          cartNotifier.removeFromCart(product),
                                ),
                                Text(
                                  '$quantity',
                                  style: TextStyle(color: Colors.pink),
                                ),
                                QuantityIconButton(
                                  icon: Icons.add,
                                  onTap: () => cartNotifier.addToCart(product),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 30.0),
                        ],
                      ),
                      SizedBox(height: 12.0),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

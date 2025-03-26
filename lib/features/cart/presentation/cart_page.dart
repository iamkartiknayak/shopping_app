import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shopping_app/common/product_discount_textspan.dart';
import 'package:shopping_app/common/product_price_textspan.dart';
import 'package:shopping_app/core/constants.dart';
import 'package:shopping_app/features/cart/application/cart_notifier.dart';
import 'package:shopping_app/features/cart/presentation/widgets/cart_summary_widget.dart';
import 'package:shopping_app/features/cart/presentation/widgets/quantity_icon_button.dart';
import 'package:shopping_app/features/product/presentation/product_page.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        title: Text("Cart"),
        centerTitle: true,
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          cartItems.isEmpty
              ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200.0,
                    child: Image.asset(
                      'assets/images/empty-cart.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    'Your cart is empty',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Add something to make me happy :)',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13.0,
                    ),
                  ),
                  SizedBox(height: 140.0),
                ],
              )
              : ListView.builder(
                padding: EdgeInsets.only(bottom: 90.0),
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final product = cartItems.keys.elementAt(index);
                  final quantity = cartItems[product]!;
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
                                Text(
                                  product.brand,
                                  style: TextStyle(fontSize: 12.0),
                                ),
                                SizedBox(height: 8.0),
                                ProductPriceTextSpan(
                                  originalPrice: product.price,
                                  discountedPrice: product.discountedPrice,
                                ),
                                SizedBox(height: 4.0),
                                ProductDiscountTextSpan(
                                  discountPercentage:
                                      product.discountPercentage,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          QuantityIconButton(
                                            icon: Icons.remove,
                                            onTap:
                                                () => cartNotifier
                                                    .removeFromCart(product),
                                          ),
                                          Text(
                                            '$quantity',
                                            style: TextStyle(
                                              color: kAccentColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          QuantityIconButton(
                                            icon: Icons.add,
                                            onTap:
                                                () => cartNotifier.addToCart(
                                                  product,
                                                ),
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
                    ),
                  );
                },
              ),
          CartSummaryWidget(cartNotifier: cartNotifier),
        ],
      ),
    );
  }
}

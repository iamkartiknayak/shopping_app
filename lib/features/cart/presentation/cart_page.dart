import 'package:flutter/material.dart';

import 'package:shopping_app/common/product_discount_textspan.dart';
import 'package:shopping_app/common/product_price_textspan.dart';
import 'package:shopping_app/core/constants.dart';
import 'package:shopping_app/features/cart/presentation/widgets/quantity_icon_button.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFEBEE),
      appBar: AppBar(title: Text("Cart"), centerTitle: true),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.white,
            margin: EdgeInsets.only(bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  "https://cdn.dummyjson.com/products/images/groceries/Honey%20Jar/thumbnail.png",
                  fit: BoxFit.contain,
                  height: 160.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 12.0),
                      Text('Honey jar', style: kProductTitleStyle),
                      SizedBox(height: 2.0),
                      Text('Some Brand', style: TextStyle(fontSize: 12.0)),
                      SizedBox(height: 8.0),
                      ProductPriceTextSpan(
                        originalPrice: 9.99,
                        discountedPrice: 9.12,
                      ),
                      SizedBox(height: 4.0),
                      ProductDiscountTextSpan(discountPercentage: 1.12),
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
                                  onTap: () {},
                                ),
                                Text('2', style: TextStyle(color: Colors.pink)),
                                QuantityIconButton(
                                  icon: Icons.add,
                                  onTap: () {},
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

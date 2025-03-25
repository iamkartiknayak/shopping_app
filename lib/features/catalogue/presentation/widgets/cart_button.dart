import 'package:flutter/material.dart';

import 'package:shopping_app/core/constants.dart';
import 'package:shopping_app/features/cart/presentation/cart_page.dart';
import 'package:shopping_app/features/catalogue/data/models/product_model.dart';

class CartButton extends StatelessWidget {
  const CartButton({super.key, required this.cartItems});

  final Map<Product, int> cartItems;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              ),
          icon: Icon(Icons.shopping_cart_outlined, size: 28.0),
        ),
        Positioned(
          top: 2.0,
          right: 8.0,
          child: IgnorePointer(
            child: Container(
              height: 20.0,
              width: 20.0,
              decoration: BoxDecoration(
                color: kAccentColor,
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(2.0),
              child: Text(
                "${cartItems.length}",
                style: TextStyle(color: Colors.white, fontSize: 10.0),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

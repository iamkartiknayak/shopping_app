import 'package:flutter/material.dart';

import 'package:shopping_app/features/cart/application/cart_notifier.dart';

class CartSummaryWidget extends StatelessWidget {
  const CartSummaryWidget({super.key, required this.cartNotifier});

  final CartNotifier cartNotifier;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Amount Price", style: TextStyle(fontSize: 13.0)),
              SizedBox(height: 10.0),
              Text(
                '\$${cartNotifier.totalPrice.toStringAsFixed(2)}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.pink,
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
            child: Row(
              children: [
                Text(
                  'Check Out',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.only(left: 6.0),
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    "${cartNotifier.totalQuantity}",
                    style: TextStyle(
                      color: Colors.pink,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

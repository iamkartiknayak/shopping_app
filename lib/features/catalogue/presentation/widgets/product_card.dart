import 'package:flutter/material.dart';

import 'package:shopping_app/features/catalogue/presentation/widgets/add_to_cart_button.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Stack(
            children: [
              Image.network(
                "https://cdn.dummyjson.com/products/images/groceries/Honey%20Jar/thumbnail.png",
                fit: BoxFit.fill,
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
                  'Honey Jar',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                SizedBox(height: 2.0),
                Text('Groceries', style: TextStyle(fontSize: 12.0)),
                SizedBox(height: 10.0),
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '\$6.99 ',
                        style: TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Colors.grey.shade600,
                          fontSize: 12.0,
                        ),
                      ),
                      TextSpan(text: ' '),
                      TextSpan(
                        text: '\$6.86',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    style: TextStyle(color: Colors.pink),
                    children: [
                      TextSpan(
                        text: '1.91% ',
                        style: TextStyle(fontSize: 13.0),
                      ),
                      TextSpan(text: 'OFF'),
                    ],
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

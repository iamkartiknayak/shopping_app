import 'package:flutter/material.dart';

import 'package:shopping_app/features/catalogue/presentation/widgets/product_card.dart';

class CataloguePage extends StatelessWidget {
  const CataloguePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFEBEE),
      appBar: AppBar(
        title: Text("Catalogue"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      body: GridView.builder(
        itemCount: 30,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.72,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 6.0,
        ),
        itemBuilder: (context, index) {
          return ProductCard();
        },
      ),
    );
  }
}

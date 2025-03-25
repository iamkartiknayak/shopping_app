import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shopping_app/core/constants.dart';
import 'package:shopping_app/features/cart/application/cart_notifier.dart';
import 'package:shopping_app/features/cart/presentation/cart_page.dart';
import 'package:shopping_app/features/catalogue/application/product_notifier.dart';
import 'package:shopping_app/features/catalogue/presentation/widgets/product_card.dart';

class CataloguePage extends ConsumerStatefulWidget {
  const CataloguePage({super.key});

  @override
  ConsumerState<CataloguePage> createState() => _CataloguePageState();
}

class _CataloguePageState extends ConsumerState<CataloguePage> {
  @override
  Widget build(BuildContext context) {
    final cartItems = ref.watch(cartProvider);
    final products = ref.watch(productNotifierProvider);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        title: Text("Catalogue"),
        centerTitle: true,
        actions: [
          Stack(
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
                    decoration: BoxDecoration(
                      color: kAccentColor,
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(4.0),
                    child: Text(
                      "${cartItems.length}",
                      style: TextStyle(color: Colors.white, fontSize: 12.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: products.when(
        data:
            (data) => GridView.builder(
              itemCount: data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.72,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 6.0,
              ),
              itemBuilder:
                  (context, index) => ProductCard(product: data[index]),
            ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text("Error: $error")),
      ),
    );
  }
}

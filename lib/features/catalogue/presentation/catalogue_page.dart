import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    final products = ref.watch(productNotifierProvider);

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

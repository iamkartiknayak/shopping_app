import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shopping_app/core/constants.dart';
import 'package:shopping_app/features/cart/application/cart_notifier.dart';
import 'package:shopping_app/features/catalogue/application/product_notifier.dart';
import 'package:shopping_app/features/catalogue/presentation/widgets/cart_button.dart';
import 'package:shopping_app/features/catalogue/presentation/widgets/catalogue_item_shimmer.dart';
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
        actions: [CartButton(cartItems: cartItems)],
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollInfo) {
          if (ref
              .read(productNotifierProvider.notifier)
              .shouldFetchMore(scrollInfo)) {
            ref.read(productNotifierProvider.notifier).fetchProducts();
          }
          return false;
        },
        child: products.when(
          data:
              (data) => GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.71,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 6.0,
                ),
                itemCount: data.length + 1,
                itemBuilder: (context, index) {
                  if (index == data.length) {
                    return CatalogueItemShimmer();
                  }
                  final product = data[index];
                  return ProductCard(product: product);
                },
              ),
          loading: () => _buildShimmerItems(),
          error: (e, stack) {
            Center(child: Text("Error: $e"));
            return _buildShimmerItems();
          },
        ),
      ),
    );
  }

  GridView _buildShimmerItems() {
    return GridView.builder(
      itemCount: 8,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.71,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 6.0,
      ),
      itemBuilder: (context, index) {
        return const CatalogueItemShimmer();
      },
    );
  }
}

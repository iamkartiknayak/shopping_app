import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shopping_app/features/catalogue/data/models/product_model.dart';

class CartNotifier extends StateNotifier<Map<Product, int>> {
  CartNotifier() : super({});

  void addToCart(Product product) {
    state = {...state, product: (state[product] ?? 0) + 1};
  }

  void removeFromCart(Product product) {
    if (!state.containsKey(product)) return;

    final newQuantity = state[product]! - 1;
    if (newQuantity <= 0) {
      final newState = Map<Product, int>.from(state);
      newState.remove(product);
      state = newState;
    } else {
      state = {...state, product: newQuantity};
    }
  }

  int get totalQuantity => state.values.fold(0, (sum, qty) => sum + qty);

  double get totalPrice => state.entries.fold(
    0,
    (sum, entry) => sum + (entry.key.price * entry.value),
  );
}

final cartProvider = StateNotifierProvider<CartNotifier, Map<Product, int>>((
  ref,
) {
  return CartNotifier();
});

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shopping_app/core/api_service.dart';
import 'package:shopping_app/features/catalogue/data/models/product_model.dart';
import 'package:shopping_app/features/catalogue/data/repositories/product_repository.dart';

final apiServiceProvider = Provider((ref) => ApiService());

final productRepositoryProvider = Provider(
  (ref) => ProductRepository(apiService: ref.read(apiServiceProvider)),
);

final productNotifierProvider =
    StateNotifierProvider<ProductNotifier, AsyncValue<List<Product>>>((ref) {
      return ProductNotifier(ref.read(productRepositoryProvider));
    });

class ProductNotifier extends StateNotifier<AsyncValue<List<Product>>> {
  final ProductRepository repository;

  bool _isFetching = false;
  int _page = 0;
  final int _limit = 8;

  bool get isFetching => _isFetching;

  ProductNotifier(this.repository) : super(const AsyncValue.loading()) {
    fetchProducts(initialLoad: true);
  }

  Future<void> fetchProducts({bool initialLoad = false}) async {
    if (_isFetching) return;
    _isFetching = true;

    try {
      final newProducts = await repository.fetchProducts(_page, _limit);

      if (initialLoad) {
        state = AsyncValue.data(newProducts);
      } else {
        state = state.whenData(
          (prevProducts) => [...prevProducts, ...newProducts],
        );
      }
      _page++;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }

    _isFetching = false;
  }

  bool shouldFetchMore(ScrollNotification scrollInfo) {
    return scrollInfo.metrics.pixels >=
        (scrollInfo.metrics.maxScrollExtent - 100);
  }
}

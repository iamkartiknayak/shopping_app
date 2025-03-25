import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/product_model.dart';
import '../data/repositories/product_repository.dart';
import '../../../core/api_service.dart';

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

  ProductNotifier(this.repository) : super(const AsyncValue.loading()) {
    fetchProducts(initialLoad: true);
  }

  Future<void> fetchProducts({bool initialLoad = false}) async {
    if (_isFetching) return;
    _isFetching = true;

    try {
      final newProducts = await repository.fetchProducts();

      if (initialLoad) {
        state = AsyncValue.data(newProducts);
      } else {
        state = state.whenData(
          (prevProducts) => [...prevProducts, ...newProducts],
        );
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }

    _isFetching = false;
  }
}

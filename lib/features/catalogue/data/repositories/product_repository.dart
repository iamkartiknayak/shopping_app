import 'dart:convert';

import 'package:shopping_app/core/api_service.dart';
import 'package:shopping_app/features/catalogue/data/models/product_model.dart';

class ProductRepository {
  final ApiService apiService;

  ProductRepository({required this.apiService});

  Future<List<Product>> fetchProducts(int page, int limit) async {
    final response = await apiService.get(
      "https://dummyjson.com/products?skip=${page * limit}&limit=$limit",
    );

    final data = jsonDecode(response);
    return (data['products'] as List).map((e) => Product.fromJson(e)).toList();
  }
}

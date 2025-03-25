class Product {
  final int id;
  final String title;
  final String category;
  final double price;
  final double discountPercentage;
  final String brand;
  final String thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.brand,
    required this.thumbnail,
  });

  double get discountedPrice => price - (price * (discountPercentage / 100));

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'No title',
      category: json['category'] ?? 'Unknown category',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      discountPercentage:
          (json['discountPercentage'] as num?)?.toDouble() ?? 0.0,

      brand: json['brand'] ?? 'Unknown brand',
      thumbnail: json['thumbnail'] ?? '',
    );
  }
}

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shopping_app/core/constants.dart';
import 'package:shopping_app/features/catalogue/data/models/product_model.dart';
import 'package:shopping_app/features/product/presentation/widgets/custom_button.dart';
import 'package:shopping_app/features/product/presentation/widgets/customer_review_widget.dart';
import 'package:shopping_app/features/product/presentation/widgets/image_slider.dart';
import 'package:shopping_app/features/product/application/image_slider_notifier.dart';
import 'package:shopping_app/features/product/presentation/widgets/image_index_indicator.dart';

class ProductPage extends ConsumerWidget {
  const ProductPage({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(imageSliderProvider);
    final sliderNotifier = ref.read(imageSliderProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
          IconButton(onPressed: () {}, icon: Icon(Icons.share_outlined)),
        ],
      ),
      body: ListView(
        children: [
          ImageSlider(product: product, sliderNotifier: sliderNotifier),
          if (product.images.length > 1)
            ImageIndexIndicator(currentIndex: currentIndex, product: product),
          SizedBox(height: 20.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4.0),
                Text.rich(
                  TextSpan(
                    text: "By ",
                    children: [
                      TextSpan(
                        text: product.brand,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  product.description,
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10.0),
                if (product.availabilityStatus != "Out of Stock")
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "\$${product.discountedPrice.toStringAsFixed(2)}",
                            style: TextStyle(
                              color: kAccentColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0,
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            "\$${product.price.toStringAsFixed(2)}",
                            style: TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        product.shippingInformation,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                SizedBox(height: 4.0),
                Text(
                  product.availabilityStatus,
                  style: TextStyle(
                    color:
                        product.availabilityStatus == "In Stock"
                            ? Colors.green
                            : Colors.red,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10.0),
                if (product.availabilityStatus != "Out of Stock")
                  Column(
                    children: [
                      CustomButton(color: Colors.black, label: "Add to Cart"),
                      SizedBox(height: 12.0),
                      CustomButton(color: kAccentColor, label: "Buy Now"),
                      SizedBox(height: 20.0),
                    ],
                  ),

                const Text(
                  "Product Details",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 6.0),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel("Brand"),
                          _buildLabel("Category"),
                          _buildLabel("Weight"),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.brand),
                          SizedBox(height: 4.0),
                          Text(product.category),
                          SizedBox(height: 4.0),
                          Text("${product.weight.ceil() * 100}g"),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20.0),

                const Text(
                  "Customer Reviews",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    buildStarRating(product.reviewAverage),
                    SizedBox(width: 4.0),
                    Text(
                      "${product.reviewAverage.ceil()} out of 5",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Text(
                  "Top reviews from India",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                ),
                SizedBox(height: 12.0),
                CustomerReviewWidget(product: product),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Row buildStarRating(double rating, {double size = 26}) {
  int totalStars = rating.ceil();

  return Row(
    mainAxisSize: MainAxisSize.min,
    children: List.generate(5, (index) {
      return index < totalStars
          ? Icon(Icons.star, size: size, color: Colors.pink)
          : Icon(Icons.star_outline, size: size, color: Colors.grey);
    }),
  );
}

Padding _buildLabel(String label) => Padding(
  padding: EdgeInsets.only(bottom: 4.0),
  child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
);

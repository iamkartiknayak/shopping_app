// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import 'package:shopping_app/core/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shopping_app/features/catalogue/data/models/product_model.dart';
import 'package:shopping_app/features/product/application/image_slider_notifier.dart';

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
          IgnorePointer(
            ignoring: product.images.length == 1,
            child: SizedBox(
              height: 300.0,
              child: CarouselSlider.builder(
                itemCount: product.images.length,
                options: CarouselOptions(
                  autoPlay: product.images.length > 1,
                  autoPlayInterval: Duration(seconds: 8),
                  autoPlayAnimationDuration: Duration(milliseconds: 1000),
                  autoPlayCurve: Curves.easeInOut,
                  height: 300.0,
                  onPageChanged:
                      (index, reason) => sliderNotifier.updateIndex(index),
                ),
                itemBuilder: (context, index, realIndex) {
                  return Image.network(
                    product.images[index],
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child; // Image loaded
                      return Shimmer.fromColors(
                        baseColor: kShimmerChildrenColor.withOpacity(0.6),
                        highlightColor: kShimmerChildrenColor.withOpacity(0.3),
                        child: Container(
                          color: Colors.grey,
                          height: 300.0,
                          width: 400.0,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          if (product.images.length > 1)
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 4.0),
              child: AnimatedSmoothIndicator(
                activeIndex: currentIndex,
                count: product.images.length,
                effect: ExpandingDotsEffect(
                  dotWidth: 8.0,
                  dotHeight: 8.0,
                  activeDotColor: kAccentColor,
                ),
              ),
            ),
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
                    _buildStarRating(product.reviewAverage),
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

                Column(
                  children:
                      product.reviews.map<Widget>((review) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey.shade400,
                                    ),
                                    padding: EdgeInsets.all(3.0),
                                    child: Icon(Icons.person_2),
                                  ),
                                  SizedBox(width: 8.0),
                                  Text(
                                    review.reviewerName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 6.0),
                              _buildStarRating(
                                review.rating.toDouble(),
                                size: 18.0,
                              ),
                              SizedBox(height: 3.0),
                              Text(
                                "Reviewed in India on ${_formatDate(review.date)}",
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 6.0),
                              Text(review.comment),
                            ],
                          ),
                        );
                      }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
      ),
    );
  }
}

Row _buildStarRating(double rating, {double size = 26}) {
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

String _formatDate(String isoDate) {
  DateTime dateTime = DateTime.parse(isoDate);
  return DateFormat("d MMMM y").format(dateTime);
}

Padding _buildLabel(String label) => Padding(
  padding: EdgeInsets.only(bottom: 4.0),
  child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
);

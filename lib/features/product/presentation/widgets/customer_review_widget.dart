import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:shopping_app/features/catalogue/data/models/product_model.dart';
import 'package:shopping_app/features/product/presentation/product_page.dart';

class CustomerReviewWidget extends StatelessWidget {
  const CustomerReviewWidget({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.0),
                  buildStarRating(review.rating.toDouble(), size: 18.0),
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
    );
  }
}

String _formatDate(String isoDate) {
  DateTime dateTime = DateTime.parse(isoDate);
  return DateFormat("d MMMM y").format(dateTime);
}

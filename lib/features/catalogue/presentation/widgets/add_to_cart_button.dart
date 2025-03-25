import 'package:flutter/material.dart';

import 'package:shopping_app/core/constants.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 8.0,
      right: 8.0,
      child: InkWell(
        onTap: onTap,
        child: Material(
          elevation: 1.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: SizedBox(
            height: 32.0,
            width: 80.0,
            child: Center(
              child: Text(
                'Add',
                style: TextStyle(
                  color: kAccentColor,
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

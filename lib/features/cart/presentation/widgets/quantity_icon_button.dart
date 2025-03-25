import 'package:flutter/material.dart';

class QuantityIconButton extends StatelessWidget {
  const QuantityIconButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Icon(icon, color: Colors.black, size: 20.0),
    );
  }
}

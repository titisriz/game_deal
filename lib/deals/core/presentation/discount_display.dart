import 'package:flutter/material.dart';

class DiscountDisplay extends StatelessWidget {
  const DiscountDisplay({
    Key? key,
    required this.savings,
  }) : super(key: key);

  final String savings;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          color: Colors.green.shade600, borderRadius: BorderRadius.circular(5)),
      child: Text(
        savings,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.lightGreen.shade100,
        ),
      ),
    );
  }
}

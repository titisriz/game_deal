import 'package:flutter/material.dart';

class PriceHorizontalSection extends StatelessWidget {
  const PriceHorizontalSection({
    Key? key,
    required this.savings,
    required this.normalPrice,
    required this.dealPrice,
  }) : super(key: key);

  final String savings;
  final String normalPrice;
  final String dealPrice;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
              color: Colors.green.shade600,
              borderRadius: BorderRadius.circular(5)),
          child: Text(
            savings,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.lightGreen.shade100,
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          normalPrice,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.lineThrough,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          dealPrice,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

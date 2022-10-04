import 'package:flutter/material.dart';
import 'package:game_deal/deals/core/presentation/discount_display.dart';

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
        DiscountDisplay(savings: savings),
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

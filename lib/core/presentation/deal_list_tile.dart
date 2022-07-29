import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:game_deal/deals/core/presentation/price_horizontal_section.dart';

class DealListTile extends StatelessWidget {
  const DealListTile({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.savings,
    required this.normalPrice,
    required this.dealPrice,
  }) : super(key: key);

  final String imageUrl;
  final String title;
  final String savings;
  final String normalPrice;
  final String dealPrice;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        style: ListTileStyle.drawer,
        leading: CircleAvatar(
          backgroundImage: CachedNetworkImageProvider(imageUrl),
        ),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        subtitle: PriceHorizontalSection(
            savings: savings, normalPrice: normalPrice, dealPrice: dealPrice),
        trailing: const Icon(Icons.navigate_next),
      ),
    );
  }
}

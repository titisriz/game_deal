import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              color: Colors.green.shade600,
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
        ),
        trailing: const Icon(Icons.navigate_next),
      ),
    );
  }
}

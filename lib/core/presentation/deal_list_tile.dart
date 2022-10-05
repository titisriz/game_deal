import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:game_deal/deals/core/presentation/price_horizontal_section.dart';
import 'package:url_launcher/url_launcher.dart';

class DealListTile extends StatelessWidget {
  const DealListTile({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.savings,
    required this.normalPrice,
    required this.dealPrice,
    required this.dealID,
  }) : super(key: key);

  final String imageUrl;
  final String title;
  final String savings;
  final String normalPrice;
  final String dealPrice;
  final String dealID;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          style: ListTileStyle.drawer,
          leading: CircleAvatar(
            backgroundImage: ResizeImage(CachedNetworkImageProvider(imageUrl),
                width: 100, height: 100),
          ),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          subtitle: PriceHorizontalSection(
              savings: savings, normalPrice: normalPrice, dealPrice: dealPrice),
          trailing: const Icon(Icons.navigate_next),
          onTap: () async {
            await launchUrl(
                Uri.parse('https://www.cheapshark.com/redirect?dealID=$dealID'),
                mode: LaunchMode.externalApplication,
                webViewConfiguration: const WebViewConfiguration(
                  enableJavaScript: true,
                ));
          },
        ),
        const Divider()
      ],
    );
  }
}

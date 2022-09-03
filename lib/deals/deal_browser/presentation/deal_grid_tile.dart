import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:game_deal/core/presentation/image_size_config.dart';
import 'package:game_deal/core/presentation/router/app_router.gr.dart';

import 'package:game_deal/deal_store/domain/deal_store.dart';
import 'package:game_deal/deals/core/domain/deal_result.dart';
import 'package:game_deal/core/presentation/image_display.dart';
import 'package:game_deal/deals/deal_browser/presentation/deal_tag.dart';
import 'package:game_deal/deals/deal_browser/presentation/icon_tag.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

class DealGridTile extends StatelessWidget {
  const DealGridTile({
    Key? key,
    this.store,
    required this.dealResult,
  }) : super(key: key);

  final DealResult dealResult;
  final DealStore? store;

  @override
  Widget build(BuildContext context) {
    final imageTag = const Uuid().v1();
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              AutoRouter.of(context).push(DealDetailRoute(
                imageTag: imageTag,
                dealResult: dealResult,
              ));
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GameImage(
                  imageTag: imageTag,
                  image: dealResult.headerImgUrl,
                  fallbackImage: dealResult.thumb,
                ),
                const SizedBox(
                  height: 10,
                ),
                GameInfo(
                  store: store,
                  title: dealResult.title,
                  rating: dealResult.rating,
                  steamRatingCount: dealResult.steamProp.steamRatingCount,
                  dealSaving: dealResult.dealSavings,
                  normalPrice: dealResult.dealNormalPrice,
                  salePrice: dealResult.dealSalePrice,
                ),
              ],
            ),
          ),
          if (store != null) GetOfferButton(dealId: dealResult.dealID)
        ],
      ),
    );
  }
}

class GameInfo extends StatelessWidget {
  const GameInfo({
    Key? key,
    required this.store,
    required this.title,
    required this.rating,
    required this.steamRatingCount,
    required this.dealSaving,
    required this.normalPrice,
    required this.salePrice,
  }) : super(key: key);

  final DealStore? store;
  final String title;
  final String rating;
  final String steamRatingCount;
  final String dealSaving;
  final String normalPrice;
  final String salePrice;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:
                Theme.of(context).textTheme.headline6?.copyWith(fontSize: 15),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconTag(
                      text: rating,
                      iconData: Icons.star_rounded,
                      size: 13,
                    ),
                    IconTag(
                        text: '$steamRatingCount Reviews',
                        iconData: Icons.comment,
                        size: 13),
                    if (store != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CachedNetworkImage(
                          imageUrl: store!.images.iconUrl,
                          cacheKey: store!.images.iconUrl,
                          memCacheHeight: 15,
                          memCacheWidth: 15,
                        ),
                      )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  DealTag(
                    tag: dealSaving,
                    fontSize: 13,
                  ),
                  DealTag(
                    tag: normalPrice,
                    textDecoration: TextDecoration.lineThrough,
                    fontSize: 13,
                  ),
                  DealTag(
                    tag: salePrice,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}

class GameImage extends StatelessWidget {
  const GameImage({
    Key? key,
    required this.image,
    required this.fallbackImage,
    required this.imageTag,
  }) : super(key: key);
  final String image;
  final String fallbackImage;
  final String imageTag;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(5),
        topRight: Radius.circular(5),
      ),
      child: Hero(
        tag: imageTag,
        child: ImageDisplay(
          url: image,
          fit: BoxFit.fitWidth,
          ratio: headerRatio,
          height: tileHeight,
          width: tileWidth,
          errorWidget: ImageDisplay(
            url: fallbackImage,
            fit: BoxFit.fitWidth,
            ratio: headerRatio,
            height: tileHeight,
            width: tileWidth,
            errorWidget: const Icon(
              MdiIcons.googleControllerOff,
              size: 50,
            ),
          ),
        ),
      ),
    );
  }
}

class GetOfferButton extends StatelessWidget {
  const GetOfferButton({
    Key? key,
    required this.dealId,
  }) : super(key: key);

  final String dealId;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap),
      onPressed: () async {
        await launchUrl(
            Uri.parse('https://www.cheapshark.com/redirect?dealID=$dealId'),
            mode: LaunchMode.inAppWebView,
            webViewConfiguration: const WebViewConfiguration(
              enableJavaScript: true,
            ));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: const [
          Text('Get Offer'),
          Icon(
            Icons.navigate_next,
          ),
        ],
      ),
    );
  }
}

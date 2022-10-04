import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:game_deal/core/presentation/image_size_config.dart';
import 'package:game_deal/core/presentation/router/app_router.gr.dart';

import 'package:game_deal/deal_store/domain/deal_store.dart';
import 'package:game_deal/deals/core/domain/deal_result.dart';
import 'package:game_deal/core/presentation/image_display.dart';
import 'package:game_deal/deals/core/presentation/discount_display.dart';
import 'package:game_deal/deals/deal_browser/presentation/deal_tag.dart';
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
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
                  dealResult: dealResult,
                  storeName: store?.storeName ?? "",
                ),
                const SizedBox(
                  height: 10,
                ),
                GameInfo(
                  store: store,
                  dealResult: dealResult,
                ),
              ],
            ),
          ),
          // GetOfferButton(dealId: dealResult.dealID)
        ],
      ),
    );
  }
}

class GameInfo extends StatelessWidget {
  const GameInfo({Key? key, required this.store, required this.dealResult})
      : super(key: key);

  final DealStore? store;
  final DealResult dealResult;

  @override
  Widget build(BuildContext context) {
    final isDiscount = double.parse(dealResult.savings) > 0;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dealResult.title,
            style:
                Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 18),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (isDiscount) const SizedBox(height: 5),
          if (isDiscount) DiscountDisplay(savings: dealResult.dealSavings),
          const SizedBox(height: 5),
          Row(
            children: [
              DealTag(
                tag: dealResult.dealSalePrice,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
              const SizedBox(
                width: 5,
              ),
              if (isDiscount)
                DealTag(
                  tag: dealResult.dealNormalPrice,
                  textDecoration: TextDecoration.lineThrough,
                  fontSize: 15,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class GameImage extends StatelessWidget {
  const GameImage({
    Key? key,
    required this.imageTag,
    required this.storeName,
    required this.dealResult,
  }) : super(key: key);
  final String imageTag;
  final String storeName;
  final DealResult dealResult;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      child: Hero(
        tag: imageTag,
        child: Stack(
          children: [
            ImageDisplay(
              url: dealResult.headerImgUrl,
              fit: BoxFit.cover,
              ratio: headerRatio,
              errorWidget: ImageDisplay(
                url: dealResult.thumb,
                fit: BoxFit.cover,
                ratio: headerRatio,
                errorWidget: const Icon(
                  MdiIcons.googleControllerOff,
                  size: 50,
                ),
              ),
            ),
            storeName.isNotEmpty
                ? Positioned(
                    bottom: 5,
                    left: 5,
                    child: Container(
                      color: Colors.black.withOpacity(0.8),
                      padding: const EdgeInsets.only(
                          top: 1, bottom: 1, left: 2, right: 2),
                      child: Text(
                        storeName,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                : Container(),
            if (dealResult.steamRatingPercent > 0)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  height: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.8),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(5))),
                  child: SizedBox(
                    child: RichText(
                      text: TextSpan(children: [
                        const WidgetSpan(
                            child: Icon(
                          Icons.star_rounded,
                          size: 15,
                        )),
                        TextSpan(
                            text: dealResult.ratingRounded,
                            style: Theme.of(context).textTheme.bodyLarge),
                      ]),
                    ),
                  ),
                ),
              )
          ],
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
            mode: LaunchMode.externalApplication,
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

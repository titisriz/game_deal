import 'package:flutter/material.dart';
import 'package:game_deal/core/presentation/image_ratio_config.dart';

import 'package:game_deal/deal_store/domain/deal_store.dart';
import 'package:game_deal/deals/core/domain/deal_result.dart';
import 'package:game_deal/core/presentation/image_display.dart';
import 'package:game_deal/deals/deal_browser/presentation/deal_tag.dart';
import 'package:game_deal/deals/deal_browser/presentation/icon_tag.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
    return Card(
      color: Colors.grey.shade100,
      shadowColor: Colors.black,
      borderOnForeground: true,
      elevation: 3,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
            child: ImageDisplay(
              url: dealResult.libraryImgUrl,
              fit: BoxFit.fitWidth,
              ratio: libraryAspectRatio,
              errorWidget: ImageDisplay(
                url: dealResult.headerImgUrl,
                fit: BoxFit.fitWidth,
                ratio: libraryAspectRatio,
                errorWidget: ImageDisplay(
                  url: dealResult.thumb,
                  fit: BoxFit.fitWidth,
                  ratio: libraryAspectRatio,
                  errorWidget: const Icon(
                    MdiIcons.googleControllerOff,
                    size: 50,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dealResult.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 15),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconTag(
                            text: dealResult.rating,
                            iconData: Icons.star_rounded,
                            size: 13,
                          ),
                          IconTag(
                              text:
                                  '${dealResult.steamProp.steamRatingCount} Reviews',
                              iconData: Icons.comment,
                              size: 13),
                          if (store != null)
                            Container(
                              color: Colors.grey[350],
                              child: SizedBox(
                                width: 13,
                                height: 13,
                                child: Image.network(store!.images.iconUrl),
                              ),
                            )
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        DealTag(
                          tag: dealResult.dealSavings,
                          fontSize: 13,
                        ),
                        DealTag(
                          tag: dealResult.dealNormalPrice,
                          textDecoration: TextDecoration.lineThrough,
                          fontSize: 13,
                        ),
                        DealTag(
                          tag: dealResult.dealSalePrice,
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
          ),
          // const Divider(),
          store == null
              ? Container()
              : InkWell(
                  onTap: () {
                    launchUrl(
                        Uri.parse(
                            'https://www.cheapshark.com/redirect?dealID=${dealResult.dealID}'),
                        mode: LaunchMode.inAppWebView,
                        webViewConfiguration: const WebViewConfiguration(
                          enableJavaScript: true,
                        ));
                  },
                  child: Container(
                    width: double.infinity,
                    color: Colors.blue,
                    height: 40,
                    padding: const EdgeInsets.only(
                        left: 5, right: 5, bottom: 5, top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Expanded(
                          flex: 5,
                          child: Text(
                            'Get offer',
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.navigate_next,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

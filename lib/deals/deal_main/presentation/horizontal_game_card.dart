import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_deal/core/presentation/image_size_config.dart';
import 'package:game_deal/core/presentation/router/app_router.gr.dart';
import 'package:game_deal/deal_store/shared/providers.dart';
import 'package:game_deal/deals/core/domain/deal_result.dart';
import 'package:game_deal/core/presentation/image_display.dart';
import 'package:game_deal/deals/core/presentation/price_horizontal_section.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:uuid/uuid.dart';

class HorizontalGameCard extends StatelessWidget {
  const HorizontalGameCard({Key? key, required this.dealResult})
      : super(key: key);
  final DealResult dealResult;
  @override
  Widget build(BuildContext context) {
    final imageTag = const Uuid().v1();
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        AutoRouter.of(context)
            .push(DealDetailRoute(imageTag: imageTag, dealResult: dealResult));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: SizedBox(
          width: size.width * 0.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    RepaintBoundary(
                      child: Hero(
                        tag: imageTag,
                        child: ImageDisplay(
                          url: dealResult.headerImgUrl,
                          ratio: horizontalGameCardRatio,
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                          errorWidget: ImageDisplay(
                            url: dealResult.thumb,
                            ratio: horizontalGameCardRatio,
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                            errorWidget: const Icon(
                              MdiIcons.googleControllerOff,
                              size: 50,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: Consumer(
                        builder: (context, ref, child) {
                          final store = ref
                              .read(dealStoreStateNotifier.notifier)
                              .getStore(dealResult.storeID);
                          if (store != null) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: CachedNetworkImage(
                                imageUrl: store.images.logoUrl,
                                cacheKey: store.images.logoUrl,
                                memCacheHeight: 52,
                                memCacheWidth: 52,
                              ),
                            );
                          }
                          return Container();
                          // stores.
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  dealResult.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: PriceHorizontalSection(
                    savings: dealResult.dealSavings,
                    normalPrice: dealResult.dealNormalPrice,
                    dealPrice: dealResult.dealSalePrice),
              ),
              const SizedBox(
                height: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}

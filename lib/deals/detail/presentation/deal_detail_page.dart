import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_deal/core/presentation/deal_list_tile.dart';
import 'package:game_deal/core/presentation/image_display.dart';
import 'package:game_deal/core/presentation/image_size_config.dart';
import 'package:game_deal/deal_store/shared/providers.dart';
import 'package:game_deal/deals/core/domain/deal_result.dart';
import 'package:game_deal/deals/core/presentation/image_placeholder.dart';
import 'package:game_deal/deals/core/shared/providers.dart';

class DealDetailPage extends ConsumerStatefulWidget {
  const DealDetailPage(
    this.imageTag, {
    Key? key,
    required this.dealResult,
  }) : super(key: key);
  final DealResult dealResult;
  final String imageTag;

  @override
  ConsumerState<DealDetailPage> createState() => _DealDetailPageState();
}

class _DealDetailPageState extends ConsumerState<DealDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref
        .read(dealDetailStateNotifier.notifier)
        .getData(widget.dealResult.gameID, widget.dealResult.storeID));
  }

  @override
  Widget build(BuildContext context) {
    final detail = ref.watch(dealDetailStateNotifier);
    final stores = ref.watch(storeById(widget.dealResult.storeID));
    final imageUrl = stores?.images.logoUrl ?? '';
    final title = stores?.storeName ?? "Get Deals";
    final savings = widget.dealResult.dealSavings;
    final normalPrice = widget.dealResult.normalPrice;
    final dealPrice = widget.dealResult.dealSalePrice;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.dealResult.title,
          style: Theme.of(context).textTheme.headline6,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.start,
        ),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: size.height * .3,
            width: size.height * .3 * 2,
            child: Hero(
              tag: widget.imageTag,
              child: ImageDisplay(
                url: widget.dealResult.headerImgUrl,
                fit: BoxFit.cover,
                alignment: Alignment.center,
                ratio: detailHeroRatio,
                errorWidget: ImageDisplay(
                  url: widget.dealResult.thumb,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  ratio: detailHeroRatio,
                  errorWidget: ImagePlaceholder(),
                ),
              ),
            ),
          ),
          Positioned(
            child: DraggableScrollableSheet(
              expand: true,
              initialChildSize: .7,
              minChildSize: .7,
              maxChildSize: 1,
              builder: (context, scrollController) => Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        blurStyle: BlurStyle.inner,
                        offset: const Offset(0, -1),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ]),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  controller: scrollController,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Current Deal',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(fontSize: 15),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        DealListTile(
                          imageUrl: imageUrl,
                          title: title,
                          savings: savings,
                          normalPrice: normalPrice,
                          dealPrice: dealPrice,
                          dealID: widget.dealResult.dealID,
                        ),
                        ...detail.when(
                          initial: () => [],
                          loadInProgress: () => [],
                          loadSuccess: (gameInfo) {
                            return [
                              if (gameInfo!.deals.isNotEmpty)
                                const SizedBox(
                                  height: 10,
                                ),
                              if (gameInfo.deals.isNotEmpty &&
                                  gameInfo.deals.length > 1)
                                Text(
                                  'Price in Other Stores',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      ?.copyWith(fontSize: 15),
                                ),
                              if (gameInfo.deals.isNotEmpty &&
                                  gameInfo.deals.length == 1)
                                Text(
                                  'Price in Other Store',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      ?.copyWith(fontSize: 15),
                                ),
                              if (gameInfo.deals.isNotEmpty)
                                const SizedBox(
                                  height: 5,
                                ),
                              ...gameInfo.deals.map(
                                (e) {
                                  final store = ref.watch(storeById(e.storeID));
                                  if (e.storeID == widget.dealResult.storeID) {
                                    return Container();
                                  }
                                  return DealListTile(
                                    imageUrl: store?.images.logoUrl ?? '',
                                    title: store?.storeName ?? '',
                                    savings: e.dealPercentage,
                                    normalPrice: e.retailPrice,
                                    dealPrice: e.price,
                                    dealID: e.dealID,
                                  );
                                },
                              ).toList(),
                            ];
                          },
                          loadFailure: (_) => [],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

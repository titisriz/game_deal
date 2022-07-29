import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_deal/core/presentation/deal_list_tile.dart';
import 'package:game_deal/core/presentation/image_display.dart';
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
        .getData(widget.dealResult.dealID));
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
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: widget.imageTag,
              child: ImageDisplay(
                url: widget.dealResult.headerImgUrl,
                errorWidget: ImagePlaceholder(
                  ratio: 2 / 1,
                ),
                fit: BoxFit.fill,
                ratio: 2 / 1,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                widget.dealResult.title,
                style: Theme.of(context).textTheme.headline6,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Current Deal',
              style:
                  Theme.of(context).textTheme.headline6?.copyWith(fontSize: 15),
            ),
            DealListTile(
              imageUrl: imageUrl,
              title: title,
              savings: savings,
              normalPrice: normalPrice,
              dealPrice: dealPrice,
            ),
            ...detail.when(
              initial: () => [],
              loadInProgress: () => [],
              loadSuccess: (dealDetail) {
                return [
                  if (dealDetail!.cheaperStores.isNotEmpty)
                    const Text('Cheaper Stores'),
                  ...dealDetail.cheaperStores.map(
                    (e) {
                      final store = ref.watch(storeById(e.storeID));
                      return DealListTile(
                          imageUrl: store?.images.logoUrl ?? '',
                          title: store?.storeName ?? '',
                          savings: e.dealPercentage,
                          normalPrice: e.retailPrice,
                          dealPrice: e.salePrice);
                    },
                  ).toList(),
                ];
              },
              loadFailure: (_) => [],
            )
          ],
        ),
      ),
    );
  }
}

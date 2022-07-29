import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_deal/core/presentation/deal_list_tile.dart';
import 'package:game_deal/core/presentation/image_display.dart';

import 'package:game_deal/deal_store/domain/deal_store.dart';
import 'package:game_deal/deal_store/shared/providers.dart';
import 'package:game_deal/deals/core/application/deal_state_notifier.dart';
import 'package:game_deal/deals/deal_main/presentation/horizontal_game_section.dart';
import 'package:game_deal/deals/deal_main/shared/providers.dart';

class DealByStoreSection extends ConsumerWidget {
  const DealByStoreSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeStores = ref.watch(activeStoreProvider);
    return Column(
      // shrinkWrap: true,
      // physics: const NeverScrollableScrollPhysics(),
      mainAxisSize: MainAxisSize.min,
      children: [
        if (activeStores.isNotEmpty)
          HorizontalGameSection(
            stateNotifierProvider: dealByStoreProvider1,
            getData: (ref) => ref
                .read(dealByStoreProvider1.notifier)
                .getDealByStore(activeStores[0].storeID),
            title: 'Top Deals in ${activeStores[0].storeName}',
          ),
        if (activeStores.length > 1)
          HorizontalGameSection(
            stateNotifierProvider: dealByStoreProvider2,
            getData: (ref) => ref
                .read(dealByStoreProvider2.notifier)
                .getDealByStore(activeStores[1].storeID),
            title: 'Top Deals in ${activeStores[1].storeName}',
          ),
        if (activeStores.length > 2)
          HorizontalGameSection(
            stateNotifierProvider: dealByStoreProvider3,
            getData: (ref) => ref
                .read(dealByStoreProvider3.notifier)
                .getDealByStore(activeStores[2].storeID),
            title: 'Top Deals in ${activeStores[2].storeName}',
          ),
        if (activeStores.length > 3)
          HorizontalGameSection(
            stateNotifierProvider: dealByStoreProvider4,
            getData: (ref) => ref
                .read(dealByStoreProvider4.notifier)
                .getDealByStore(activeStores[3].storeID),
            title: 'Top Deals in ${activeStores[3].storeName}',
          ),
      ],
    );
  }
}

class DealByStoreList extends ConsumerStatefulWidget {
  const DealByStoreList({
    Key? key,
    required this.dealStore,
    required this.state,
  }) : super(key: key);
  final DealStore dealStore;
  final StateNotifierProvider<DealStateNotifier, DealState> state;

  @override
  ConsumerState<DealByStoreList> createState() => _DealByStoreListState();
}

class _DealByStoreListState extends ConsumerState<DealByStoreList> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref
        .watch(widget.state.notifier)
        .getDealByStore(widget.dealStore.storeID));
  }

  @override
  Widget build(BuildContext context) {
    final dealByStore = ref.watch(widget.state);
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: dealByStore.map(
        initial: (_) => 0,
        loadInProgress: (_) => 0,
        loadSuccess: (_) => _.dealResults.content.length,
        loadFailure: (_) => 0,
      ),
      itemBuilder: (context, index) {
        return dealByStore.map(
          initial: (_) => Container(),
          loadInProgress: (_) => Container(),
          loadSuccess: (_) {
            if (index == 0) {
              return Row(
                children: [
                  SizedBox(
                    height: 30,
                    child: ImageDisplay(
                      url: widget.dealStore.images.logoUrl,
                      errorWidget: Container(),
                      ratio: 16 / 9,
                    ),
                  ),
                  Text(
                    widget.dealStore.storeName,
                    style: Theme.of(context).textTheme.headline5,
                  )
                ],
              );
            }
            final dealResult = _.dealResults.content[index - 1];
            return DealListTile(
              imageUrl: dealResult.thumb,
              title: dealResult.title,
              savings: dealResult.dealSavings,
              normalPrice: dealResult.dealNormalPrice,
              dealPrice: dealResult.dealSalePrice,
            );
          },
          loadFailure: (_) => Container(),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:game_deal/deal_store/shared/providers.dart';
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

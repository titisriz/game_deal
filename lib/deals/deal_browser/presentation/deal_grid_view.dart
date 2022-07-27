import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:game_deal/core/infrastructure/pagination_config.dart';
import 'package:game_deal/deal_store/application/deal_store_state_notifier.dart';
import 'package:game_deal/deals/core/application/deal_state_notifier.dart';
import 'package:game_deal/deals/core/shared/providers.dart';
import 'package:game_deal/deals/deal_browser/presentation/deal_grid_tile.dart';
import 'package:game_deal/deals/deal_browser/presentation/deal_grid_tile_loading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DealGridView extends ConsumerWidget {
  const DealGridView({
    Key? key,
    required this.state,
    required this.dealStateNotifier,
    required this.dealStoreStateNotifier,
    required this.canLoadNextPage,
  }) : super(key: key);
  final bool canLoadNextPage;
  final DealStoreStateNotifier dealStoreStateNotifier;
  final DealStateNotifier dealStateNotifier;
  final DealState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dealFilterState = ref.watch(filterStateNotifierProvider);
    final filterStateNotifier = ref.watch(filterStateNotifierProvider.notifier);
    bool _canLoadNextPage = canLoadNextPage;
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        final metrics = notification.metrics;
        final limit = metrics.maxScrollExtent - metrics.viewportDimension / 2;
        if (_canLoadNextPage && metrics.pixels >= limit) {
          filterStateNotifier.setFilter(dealFilterState.copyWith(
              pageNumber: dealFilterState.pageNumber + 1));
          final newDealFilterState = ref.watch(filterStateNotifierProvider);
          print('new dealFilterState ${newDealFilterState.pageNumber}');
          dealStateNotifier.getFilteredDeal(newDealFilterState);
          _canLoadNextPage = false;
        }

        return false;
      },
      child: MasonryGridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        // crossAxisCount: 2,

        mainAxisSpacing: 5,
        crossAxisSpacing: 2,
        itemCount: state.map(
            initial: (_) => _.dealResults.content.length,
            loadInProgress: (_) =>
                _.dealResults.content.length + dealPaginationSizeLoading,
            loadSuccess: (_) {
              return _.dealResults.isEmptyResult
                  ? 1
                  : _.dealResults.content.length;
            },
            loadFailure: (_) => _.dealResults.content.length + 1),

        itemBuilder: (context, index) {
          return state.map(
            initial: (_) => Container(),
            loadInProgress: (_) {
              if (index < _.dealResults.content.length) {
                final deal = _.dealResults.content[index];
                final store = dealStoreStateNotifier.getStore(deal.storeID);
                return DealGridTile(
                  dealResult: deal,
                  store: store,
                );
              }
              return const DealGridTileLoading();
            },
            loadSuccess: (_) {
              final deal = _.dealResults.content[index];
              final store = dealStoreStateNotifier.getStore(deal.storeID);
              return DealGridTile(
                dealResult: deal,
                store: store,
              );
            },
            loadFailure: (_) => Container(),
          );
        },
      ),
    );
  }
}

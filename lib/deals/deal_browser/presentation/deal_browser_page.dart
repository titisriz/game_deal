import 'package:flutter/material.dart';
import 'package:game_deal/deals/core/shared/providers.dart';
import 'package:game_deal/deal_store/shared/providers.dart';
import 'package:game_deal/deals/deal_browser/presentation/deal_grid_view.dart';
import 'package:game_deal/deals/deal_search/presentation/filter_form.dart';
import 'package:game_deal/deals/deal_browser/presentation/no_result.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DealBrowserPage extends ConsumerStatefulWidget {
  const DealBrowserPage({Key? key}) : super(key: key);

  @override
  ConsumerState<DealBrowserPage> createState() => _DealBrowserPageState();
}

class _DealBrowserPageState extends ConsumerState<DealBrowserPage> {
  bool _canLoadNextPage = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () {
        final state = ref.watch(dealStateNotifierProvider);
        return state.maybeMap(
          orElse: () {},
          initial: (_) {
            return ref
                .read(dealStateNotifierProvider.notifier)
                .getFirstPageDeal();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dealStateNotifierProvider);
    final safeArea = SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: state.map(
          initial: (_) {
            _canLoadNextPage = false;
            return null;
          },
          loadFailure: (_) {
            _canLoadNextPage = false;
            return null;
          },
          loadSuccess: (_) {
            _canLoadNextPage = _.dealResults.isNextPageAvailable;
            if (_.dealResults.isEmptyResult) {
              return const NoResult();
            }
            return DealGridView(
              canLoadNextPage: _canLoadNextPage,
              dealStateNotifier: ref.watch(dealStateNotifierProvider.notifier),
              dealStoreStateNotifier:
                  ref.watch(dealStoreStateNotifier.notifier),
              state: state,
            );
          },
          loadInProgress: (_) => DealGridView(
            canLoadNextPage: false,
            dealStateNotifier: ref.watch(dealStateNotifierProvider.notifier),
            dealStoreStateNotifier: ref.watch(dealStoreStateNotifier.notifier),
            state: state,
          ),
        ),
      ),
    );
    final appBar2 = AppBar(
      title: const Text('Browse Deal'),
      actions: [
        IconButton(
          splashRadius: 20,
          onPressed: () {
            showModalBottomSheet(
              backgroundColor: Theme.of(context).cardTheme.color,
              // anchorPoint: const Offset(0, 10),
              isScrollControlled: true,
              enableDrag: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              context: context,
              builder: (context) {
                return const FilterForm();
              },
            );
          },
          icon: const Icon(Icons.filter_alt_sharp),
        ),
      ],
    );
    return Scaffold(
      appBar: appBar2,
      body: safeArea,
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_deal/deals/deal_search/application/form_filter_state.dart';
import 'package:game_deal/deals/core/shared/providers.dart';
import 'package:game_deal/deal_store/shared/providers.dart';

class FilterForm extends ConsumerStatefulWidget {
  const FilterForm({Key? key}) : super(key: key);

  @override
  ConsumerState<FilterForm> createState() => _FilterFormState();
}

class _FilterFormState extends ConsumerState<FilterForm> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final filter = ref.watch(browseFilterStateNotifierProvider);
      ref
          .read(formFilterStateNotifierProvider.notifier)
          .convertStateFromDomain(filter);
    });
  }

  @override
  Widget build(BuildContext context) {
    final filterFormStateNotifier =
        ref.watch(formFilterStateNotifierProvider.notifier);
    final filterFormState = ref.watch(formFilterStateNotifierProvider);
    final titleStyle =
        Theme.of(context).textTheme.headline6?.copyWith(fontSize: 15);
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.80,
      // padding: const EdgeInsets.all(10.0),
      width: double.infinity,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: SizedBox(
              width: 100,
              child: Divider(height: 5, thickness: 5, color: Colors.grey),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Divider(color: Colors.grey, height: 1),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sort By',
                            style: titleStyle,
                          ),
                          TextButton(
                              onPressed: () =>
                                  filterFormStateNotifier.resetFilter(),
                              child: const Text('Reset Filter'))
                        ],
                      ),
                      Wrap(
                        children: sortMap.entries
                            .map((mapEntry) => Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: FilterChip(
                                    label: Text(mapEntry.key),
                                    selected:
                                        filterFormState.sortBy == mapEntry.key
                                            ? true
                                            : false,
                                    onSelected: (bool selected) {
                                      filterFormStateNotifier.updateState(
                                        filterFormState.copyWith(
                                          sortBy: mapEntry.key,
                                        ),
                                      );
                                    },
                                  ),
                                ))
                            .toList(),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Price',
                        style: titleStyle,
                      ),
                      PriceRangeSlider(
                          filterFormState: filterFormState,
                          filterFormStateNotifier: filterFormStateNotifier),
                      Text(
                        'Steam Rating',
                        style: titleStyle,
                      ),
                      SteamRatingSlider(
                          filterFormState: filterFormState,
                          filterFormStateNotifier: filterFormStateNotifier),
                      StoreSelectionTitle(
                          titleStyle: titleStyle,
                          filterFormStateNotifier: filterFormStateNotifier,
                          ref: ref),
                      StoreSelection(
                          ref: ref,
                          filterFormState: filterFormState,
                          filterFormStateNotifier: filterFormStateNotifier),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Steam Works',
                            style: titleStyle,
                          ),
                          Switch.adaptive(
                            value: filterFormState.steamWorksSelected,
                            onChanged: ((value) {
                              filterFormStateNotifier.updateState(
                                filterFormState.copyWith(
                                  steamWorksSelected: value,
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'On Sale',
                            style: titleStyle,
                          ),
                          Switch.adaptive(
                            value: filterFormState.onSale,
                            onChanged: ((value) {
                              filterFormStateNotifier.updateState(
                                filterFormState.copyWith(
                                  onSale: value,
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SubmitButton(ref: ref, filterFormState: filterFormState),
        ],
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key? key,
    required this.ref,
    required this.filterFormState,
  }) : super(key: key);

  final WidgetRef ref;
  final FormFilterState filterFormState;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(shape: const BeveledRectangleBorder()),
        onPressed: () {
          final browseFilterStateNotifier =
              ref.watch(browseFilterStateNotifierProvider.notifier);
          browseFilterStateNotifier.setFilter(toDealFilter(filterFormState));

          final dealState = ref.watch(dealStateNotifierProvider.notifier);
          dealState.resetState();
          dealState.getFirstPageDeal(filter: toDealFilter(filterFormState));
          Navigator.of(context).pop();
        },
        child: const Text(
          'Submit',
        ),
      ),
    );
  }
}

class StoreSelectionTitle extends StatelessWidget {
  const StoreSelectionTitle({
    Key? key,
    required this.titleStyle,
    required this.filterFormStateNotifier,
    required this.ref,
  }) : super(key: key);

  final TextStyle? titleStyle;
  final FormFilterStateNotifier filterFormStateNotifier;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
            child: Text(
          'Store',
          style: titleStyle,
        )),
        TextButton(
          style: TextButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap),
          child: const Text('All'),
          onPressed: () {
            filterFormStateNotifier.selectMultipleStores(
                ref.watch(activeStoreProvider).map((e) => e.storeID).toList());
          },
        ),
        TextButton(
          child: const Text('Clear'),
          onPressed: () {
            filterFormStateNotifier.removeAllSelectedStores();
          },
          style: TextButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap),
        )
      ],
    );
  }
}

class SteamRatingSlider extends StatelessWidget {
  const SteamRatingSlider({
    Key? key,
    required this.filterFormState,
    required this.filterFormStateNotifier,
  }) : super(key: key);

  final FormFilterState filterFormState;
  final FormFilterStateNotifier filterFormStateNotifier;

  @override
  Widget build(BuildContext context) {
    return Slider(
      min: 0,
      max: 90,
      value: filterFormState.steamRating,
      divisions: 9,
      onChanged: (val) {
        filterFormStateNotifier.updateState(
          filterFormState.copyWith(
            steamRating: val,
          ),
        );
      },
      label: filterFormState.steamRating == 0
          ? 'Any'
          : '> ${filterFormState.steamRating.toStringAsFixed(0)}',
    );
  }
}

class PriceRangeSlider extends StatelessWidget {
  const PriceRangeSlider({
    Key? key,
    required this.filterFormState,
    required this.filterFormStateNotifier,
  }) : super(key: key);

  final FormFilterState filterFormState;
  final FormFilterStateNotifier filterFormStateNotifier;

  @override
  Widget build(BuildContext context) {
    return RangeSlider(
      min: 0,
      max: 50,
      values:
          RangeValues(filterFormState.lowerPrice, filterFormState.upperPrice),
      divisions: 10,
      onChanged: (val) {
        filterFormStateNotifier.updateState(
          filterFormState.copyWith(upperPrice: val.end, lowerPrice: val.start),
        );
      },
      labels: RangeLabels(
        '\$${filterFormState.lowerPrice.toString()}',
        '\$${filterFormState.upperPriceDisplay}',
      ),
    );
  }
}

class StoreSelection extends StatelessWidget {
  const StoreSelection({
    Key? key,
    required this.ref,
    required this.filterFormState,
    required this.filterFormStateNotifier,
  }) : super(key: key);

  final WidgetRef ref;
  final FormFilterState filterFormState;
  final FormFilterStateNotifier filterFormStateNotifier;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      direction: Axis.horizontal,
      spacing: 0,
      children: [
        ...ref
            .watch(activeStoreProvider)
            .map((e) => Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    key: Key(e.storeID),
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            cacheKey: e.images.iconUrl,
                            imageUrl: e.images.iconUrl,
                            memCacheHeight: 15,
                            memCacheWidth: 15,
                          ),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(e.storeName),
                      ],
                    ),
                    selected: filterFormState.isStoreSelected(e.storeID),
                    onSelected: (value) {
                      filterFormStateNotifier.switchSelectStore(
                          value, e.storeID);
                    },
                  ),
                ))
            .toList()
      ],
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_deal/deals/core/application/filter_form_state.dart';
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
      final filter = ref.watch(filterStateNotifierProvider);
      final filterFormStateNotifier =
          ref.watch(filterFormStateNotifierProvider.notifier);
      filterFormStateNotifier.convertStateFromDomain(filter);
    });
  }

  @override
  Widget build(BuildContext context) {
    final filterFormStateNotifier =
        ref.watch(filterFormStateNotifierProvider.notifier);
    final filterFormState = ref.watch(filterFormStateNotifierProvider);
    final dealState = ref.watch(dealStateNotifierProvider.notifier);

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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
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
                            style: Theme.of(context).textTheme.headline6,
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
                        'Filter',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const Text(
                        'Price',
                        style: TextStyle(fontSize: 15),
                      ),
                      RangeSlider(
                        min: 0,
                        max: 50,
                        values: RangeValues(filterFormState.lowerPrice,
                            filterFormState.upperPrice),
                        divisions: 10,
                        onChanged: (val) {
                          filterFormStateNotifier.updateState(
                            filterFormState.copyWith(
                                upperPrice: val.end, lowerPrice: val.start),
                          );
                        },
                        labels: RangeLabels(
                          '\$${filterFormState.lowerPrice.toString()}',
                          '\$${filterFormState.upperPriceDisplay}',
                        ),
                      ),
                      const Text(
                        'Steam Rating',
                        style: TextStyle(fontSize: 15),
                      ),
                      Slider(
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
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(child: Text('Store')),
                          TextButton(
                            child: const Text('Clear'),
                            onPressed: () {
                              filterFormStateNotifier.removeAllSelectedStores();
                            },
                          )
                        ],
                      ),
                      Wrap(
                        // crossAxisAlignment: WrapCrossAlignment.start,
                        alignment: WrapAlignment.start,
                        direction: Axis.horizontal,
                        spacing: 0,
                        // verticalDirection: VerticalDirection.down,
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
                                          Text(e.storeName),
                                          const SizedBox(
                                            width: 2,
                                          ),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: CachedNetworkImage(
                                                imageUrl: e.images.iconUrl),
                                          ),
                                        ],
                                      ),
                                      selected: filterFormState
                                          .isStoreSelected(e.storeID),
                                      onSelected: (value) {
                                        filterFormStateNotifier
                                            .switchSelectStore(
                                                value, e.storeID);
                                      },
                                    ),
                                  ))
                              .toList()
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Steam Works',
                            style: TextStyle(fontSize: 15),
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
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: const BeveledRectangleBorder()),
              onPressed: () {
                final filterStateNotifier =
                    ref.watch(filterStateNotifierProvider.notifier);
                filterStateNotifier.setFilter(toDomain(filterFormState));

                dealState.resetState();
                dealState.getFirstPageDeal(filter: toDomain(filterFormState));
                Navigator.of(context).pop();
              },
              child: const Text(
                'Submit',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

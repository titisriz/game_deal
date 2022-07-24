import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_deal/deals/core/domain/deal_filter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'filter_form_state.freezed.dart';

@freezed
class FilterFormState with _$FilterFormState {
  const FilterFormState._();
  factory FilterFormState({
    required double upperPrice,
    required double lowerPrice,
    required double steamRating,
    String? sortBy,
    String? title,
    required String selectedStoreId,
    required bool steamWorksSelected,
  }) = _FilterFormState;

  factory FilterFormState.initial() {
    return FilterFormState(
        upperPrice: 50,
        lowerPrice: 0,
        steamRating: 0,
        steamWorksSelected: false,
        selectedStoreId: "",
        sortBy: sortByFromDomain('Deal Rating'));
  }
  factory FilterFormState.fromDomain(DealFilter dealFilter) {
    return FilterFormState(
      upperPrice: dealFilter.upperPrice == null
          ? 50
          : dealFilter.upperPrice!.toDouble(),
      lowerPrice:
          dealFilter.lowerPrice == null ? 0 : dealFilter.lowerPrice!.toDouble(),
      steamRating: dealFilter.steamRating == null
          ? 0
          : dealFilter.steamRating!.toDouble(),
      steamWorksSelected: (dealFilter.steamworks ?? 0) == 1 ? true : false,
      sortBy: sortByFromDomain(dealFilter.sortBy ?? 'Deal Rating'),
      selectedStoreId: dealFilter.storeID ?? '',
    );
  }
  Set<String> get selectedStoreIdSet {
    return selectedStoreId.split(',').where((element) => element != '').toSet();
  }

  bool isStoreSelected(String storeId) {
    return selectedStoreIdSet.contains(storeId);
  }

  String get upperPriceDisplay =>
      50 == upperPrice ? "50.0+" : upperPrice.toString();
}

class FilterFormStateNotifier extends StateNotifier<FilterFormState> {
  FilterFormStateNotifier() : super(FilterFormState.initial());

  void convertStateFromDomain(DealFilter dealFilter) {
    state = FilterFormState.fromDomain(dealFilter);
  }

  void updateState(FilterFormState filterFormState) {
    state = filterFormState;
  }

  void switchSelectStore(bool selected, String storeId) {
    if (selected) {
      _addSelectedIdStore(storeId);
    } else {
      _removeSelectedIdStore(storeId);
    }
  }

  void _addSelectedIdStore(String storeId) {
    var set = state.selectedStoreIdSet;
    set.add(storeId);
    state = state.copyWith(
      selectedStoreId: set.join(','),
    );
  }

  void _removeSelectedIdStore(String storeId) {
    var set = state.selectedStoreIdSet;
    set.remove(storeId);
    state = state.copyWith(
      selectedStoreId: set.join(','),
    );
  }

  void removeAllSelectedStores() {
    state = state.copyWith(
      selectedStoreId: '',
    );
  }

  void resetFilter() {
    state = FilterFormState.initial();
  }
}

DealFilter toDomain(FilterFormState filterFormState) {
  return DealFilter.baseFilter().copyWith(
      upperPrice: filterFormState.upperPrice.toInt(),
      lowerPrice: filterFormState.lowerPrice.toInt(),
      steamRating: filterFormState.steamRating.toInt() == 0
          ? null
          : filterFormState.steamRating.toInt(),
      steamworks: filterFormState.steamWorksSelected ? 1 : 0,
      sortBy: sortByToDomain(filterFormState.sortBy),
      storeID: filterFormState.selectedStoreId.isEmpty
          ? null
          : filterFormState.selectedStoreId);
}

Map<String, String> get sortMap => {
      'Best Deal': 'Deal Rating',
      'Reviews': 'Reviews',
      'Lowest Price': 'Price',
    };

Map<String, String> get sortMapInverted {
  return sortMap.map((key, val) => MapEntry(val, key));
}

String? sortByToDomain(String? key) {
  return sortMap[key];
}

String? sortByFromDomain(String? key) {
  return sortMapInverted[key];
}

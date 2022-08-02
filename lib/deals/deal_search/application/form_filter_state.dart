import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_deal/deals/core/application/browser_filter_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'form_filter_state.freezed.dart';

@freezed
class FormFilterState with _$FormFilterState {
  const FormFilterState._();
  factory FormFilterState({
    required double upperPrice,
    required double lowerPrice,
    required double steamRating,
    String? sortBy,
    String? title,
    required String selectedStoreId,
    required bool steamWorksSelected,
    required bool onSale,
  }) = _FormFilterState;

  factory FormFilterState.initial() {
    return FormFilterState(
      upperPrice: 50,
      lowerPrice: 0,
      steamRating: 0,
      steamWorksSelected: false,
      selectedStoreId: "",
      sortBy: sortByFromDomain('Deal Rating'),
      onSale: false,
    );
  }
  factory FormFilterState.fromDealFilter(DealFilter dealFilter) {
    return FormFilterState(
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
      onSale: (dealFilter.onSale ?? 0) == 1 ? true : false,
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

class FormFilterStateNotifier extends StateNotifier<FormFilterState> {
  FormFilterStateNotifier() : super(FormFilterState.initial());

  void convertStateFromDomain(DealFilter dealFilter) {
    state = FormFilterState.fromDealFilter(dealFilter);
  }

  void updateState(FormFilterState formFilterState) {
    state = formFilterState;
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

  void selectMultipleStores(List<String> storeIds) {
    state = state.copyWith(selectedStoreId: storeIds.join(','));
  }

  void resetFilter() {
    state = FormFilterState.initial();
  }
}

DealFilter toDealFilter(FormFilterState formFilterState) {
  return DealFilter.baseFilter().copyWith(
      upperPrice: formFilterState.upperPrice.toInt(),
      lowerPrice: formFilterState.lowerPrice.toInt(),
      steamRating: formFilterState.steamRating.toInt() == 0
          ? null
          : formFilterState.steamRating.toInt(),
      steamworks: formFilterState.steamWorksSelected ? 1 : 0,
      sortBy: sortByToDomain(formFilterState.sortBy),
      storeID: formFilterState.selectedStoreId.isEmpty
          ? null
          : formFilterState.selectedStoreId,
      onSale: formFilterState.onSale ? 1 : 0);
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

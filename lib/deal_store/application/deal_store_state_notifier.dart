import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:game_deal/deal_store/domain/deal_store.dart';
import 'package:game_deal/deal_store/infrastructure/deal_store_repository.dart';

part 'deal_store_state_notifier.freezed.dart';

@freezed
class DealStoreState with _$DealStoreState {
  const DealStoreState._();
  const factory DealStoreState.initial(List<DealStore> stores) = _Initial;
  const factory DealStoreState.loading(List<DealStore> stores) = _Loading;
  const factory DealStoreState.loadSuccess(List<DealStore> stores) =
      _LoadSuccess;
  const factory DealStoreState.emptyData(List<DealStore> stores) = _EmptyData;
}

class DealStoreStateNotifier extends StateNotifier<DealStoreState> {
  final DealStoreRepository _repository;
  DealStoreStateNotifier(
    this._repository,
  ) : super(const DealStoreState.initial([]));

  Future<void> fetchStoreData() async {
    state = const DealStoreState.loading([]);
    final stores = await _repository.getStores();
    stores.isEmpty
        ? state = DealStoreState.emptyData(stores)
        : state = DealStoreState.loadSuccess(stores);
  }

  DealStore? getStore(String storeID) {
    return state
        .maybeMap(
            orElse: () => null,
            loadSuccess: (_) =>
                _.stores.where((store) => store.storeID == storeID))
        ?.first;
  }
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_deal/core/domain/page.dart';
import 'package:game_deal/deals/core/application/browser_filter_state.dart';
import 'package:game_deal/deals/core/domain/deal_result.dart';
import 'package:game_deal/deals/core/infrastructure/deal_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:game_deal/core/domain/failures.dart';

part 'deal_state_notifier.freezed.dart';

@freezed
class DealState with _$DealState {
  const factory DealState.initial(Page<DealResult> dealResults) = _Initial;
  const factory DealState.loadInProgress(Page<DealResult> dealResults) =
      _LoadInProgress;
  const factory DealState.loadSuccess(Page<DealResult> dealResults) =
      _LoadSuccess;
  const factory DealState.loadFailure(
      Page<DealResult> dealResults, DealFailure failure) = _LoadFailure;
}

class DealStateNotifier extends StateNotifier<DealState> {
  final DealRepository _dealRepository;
  DealStateNotifier(
    this._dealRepository,
  ) : super(DealState.initial(Page.empty()));

  Future<void> getFilteredDeal(DealFilter filter) async {
    state = DealState.loadInProgress(state.dealResults);
    final failureOrResult = await _dealRepository.getDeals(filter.toJson());
    state = failureOrResult.fold(
      (l) =>
          l.map(apiFailure: (_) => DealState.loadFailure(state.dealResults, _)),
      (r) => DealState.loadSuccess(r.copyWith(content: [
        ...state.dealResults.content,
        ...r.content,
      ])),
    );
  }

  Future<void> getFreeGames() async {
    resetState();
    final filter = DealFilter.freeGameFilter();
    // state = DealState.loadSuccess(Page.empty());
    await getFilteredDeal(filter);
  }

  Future<void> getMostRecentDeal() async {
    resetState();
    final filter = DealFilter.mostRecentFilter();
    await getFilteredDeal(filter);
  }

  Future<void> getPopularDeal() async {
    resetState();
    final filter = DealFilter.popularGameFilter();
    await getFilteredDeal(filter);
  }

  Future<void> getDealByStore(String storeId) async {
    resetState();
    final filter = DealFilter.dealByStore(storeId);
    await getFilteredDeal(filter);
  }

  void resetState() {
    state = DealState.initial(Page.empty());
  }

  Future<void> getFirstPageDeal({DealFilter? filter}) async {
    state = DealState.loadInProgress(state.dealResults);
    final failureOrResult = await _dealRepository
        .getDeals(filter?.toJson() ?? DealFilter.baseFilter().toJson());
    state = failureOrResult.fold(
      (l) =>
          l.map(apiFailure: (_) => DealState.loadFailure(state.dealResults, _)),
      (r) => DealState.loadSuccess(r),
    );
  }
}

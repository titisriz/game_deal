import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_deal/core/domain/failures.dart';
import 'package:game_deal/deals/core/domain/game_info.dart';
import 'package:game_deal/deals/core/infrastructure/game_info_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'deal_detail_state_notifier.freezed.dart';

@freezed
class DealDetailState with _$DealDetailState {
  const DealDetailState._();
  const factory DealDetailState.initial() = _Initial;
  const factory DealDetailState.loadInProgress() = _LoadInProgress;
  const factory DealDetailState.loadSuccess(GameInfo? gameInfo) = _LoadSuccess;
  const factory DealDetailState.loadFailure(DealFailure dealFailure) =
      _LoadFailure;
}

class DealDetailStateNotifier extends StateNotifier<DealDetailState> {
  DealDetailStateNotifier(this.gameInfoRepository)
      : super(const DealDetailState.initial());
  GameInfoRepository gameInfoRepository;

  void getData(String gameId, String excludedStoreID) async {
    state = const DealDetailState.loadInProgress();
    final response = await gameInfoRepository.getInfo(gameId);
    state = response.fold(
      (l) => DealDetailState.loadFailure(l),
      (r) {
        List<DealInfo>? deals = r == null ? [] : List.from(r.deals);
        deals.sort(
          (a, b) => double.parse(a.price).compareTo(double.parse(b.price)),
        );
        return DealDetailState.loadSuccess(r?.copyWith(
            deals: deals
                .where((element) => element.storeID != excludedStoreID)
                .toList()));
      },
    );
  }
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_deal/core/domain/failures.dart';
import 'package:game_deal/deals/core/domain/deal_detail.dart';
import 'package:game_deal/deals/core/infrastructure/deal_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'deal_detail_state_notifier.freezed.dart';

@freezed
class DealDetailState with _$DealDetailState {
  const DealDetailState._();
  const factory DealDetailState.initial() = _Initial;
  const factory DealDetailState.loadInProgress() = _LoadInProgress;
  const factory DealDetailState.loadSuccess(DealDetail? dealDetail) =
      _LoadSuccess;
  const factory DealDetailState.loadFailure(DealFailure dealFailure) =
      _LoadFailure;
}

class DealDetailStateNotifier extends StateNotifier<DealDetailState> {
  DealDetailStateNotifier(this.dealRepository)
      : super(const DealDetailState.initial());
  DealRepository dealRepository;

  void getData(String dealId) async {
    state = const DealDetailState.loadInProgress();
    final response = await dealRepository.getDetail(dealId);
    state = response.fold(
      (l) => DealDetailState.loadFailure(l),
      (r) => DealDetailState.loadSuccess(r),
    );
  }
}

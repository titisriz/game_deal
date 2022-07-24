import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_deal/deals/core/infrastructure/cheaper_store_dto.dart';
import 'package:game_deal/deals/core/infrastructure/detail_game_info_dto.dart';
part 'deal_detail.freezed.dart';
@freezed
class DealDetail with _$DealDetail {
  const DealDetail._();
  const factory DealDetail({
    required DetailGameInfoDto gameInfo,
    required List<CheaperStoreDto> cheaperStores,
  }) = _DealDetail;
}

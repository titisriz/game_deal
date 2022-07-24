import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_deal/deals/core/domain/deal_detail.dart';
import 'package:game_deal/deals/core/infrastructure/cheaper_store_dto.dart';
import 'package:game_deal/deals/core/infrastructure/detail_game_info_dto.dart';
part 'deal_detail_dto.freezed.dart';
part 'deal_detail_dto.g.dart';

@freezed
class DealDetailDto with _$DealDetailDto {
  const DealDetailDto._();
  const factory DealDetailDto({
    required DetailGameInfoDto gameInfo,
    required List<CheaperStoreDto> cheaperStores,
  }) = _DealDetailDto;

  factory DealDetailDto.fromJson(Map<String, dynamic> json) =>
      _$DealDetailDtoFromJson(json);
  factory DealDetailDto.fromDomain(DealDetail domain) => DealDetailDto(
        gameInfo: domain.gameInfo,
        cheaperStores: domain.cheaperStores,
      );

  DealDetail toDomain() => DealDetail(
        gameInfo: gameInfo,
        cheaperStores: cheaperStores,
      );
}

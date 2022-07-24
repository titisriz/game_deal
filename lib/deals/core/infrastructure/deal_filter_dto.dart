import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_deal/deals/core/domain/deal_filter.dart';

part 'deal_filter_dto.freezed.dart';
part 'deal_filter_dto.g.dart';

@freezed
@JsonSerializable(includeIfNull: false)
class DealFilterDto with _$DealFilterDto {
  const DealFilterDto._();
  const factory DealFilterDto({
    String? storeID,
    required String pageNumber,
    required String pageSize, //max 60
    String?
        sortBy, //Deal Rating + Title + Savings + Price + Metacritic + Reviews + Release + Store + recent
    String? desc, //0/1
    String? lowerPrice,
    String? upperPrice,
    String? metacritic,
    String? steamRating,
    String? steamAppID,
    String? title,
    String? steamworks, //
  }) = _DealFilterDto;

  @override
  Map<String, dynamic> toJson() => _$DealFilterDtoToJson(this);

  factory DealFilterDto.fromDomain(DealFilter filter) => DealFilterDto(
        storeID: filter.storeID,
        pageNumber: filter.pageNumber.toString(),
        pageSize: filter.pageSize.toString(), //max 60
        sortBy: filter
            .sortBy, //Deal Rating + Title + Savings + Price + Metacritic + Reviews + Release + Store + recent
        desc: filter.desc?.toString(), //0/1
        lowerPrice: filter.lowerPrice?.toString(),
        upperPrice: filter.upperPrice?.toString(),
        metacritic: filter.metacritic?.toString(),
        steamRating: filter.steamRating?.toString(),
        steamAppID: filter.steamAppID,
        title: filter.title,
        steamworks: filter.steamworks?.toString(), //
      );
}

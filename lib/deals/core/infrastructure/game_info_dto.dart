import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_deal/deals/core/domain/game_info.dart';
part 'game_info_dto.freezed.dart';
part 'game_info_dto.g.dart';

@freezed
class GameInfoDto with _$GameInfoDto {
  const GameInfoDto._();
  const factory GameInfoDto({
    required GeneralInfoDto info,
    required CheapestPriceTimeDto cheapestPriceEver,
    required List<DealInfoDto> deals,
  }) = _GameInfoDto;
  factory GameInfoDto.fromJson(Map<String, dynamic> json) =>
      _$GameInfoDtoFromJson(json);
  factory GameInfoDto.fromDomain(GameInfo domain) => GameInfoDto(
        info: GeneralInfoDto.fromDomain(domain.info),
        cheapestPriceEver:
            CheapestPriceTimeDto.fromDomain(domain.cheapestPriceEver),
        deals: domain.deals.map((e) => DealInfoDto.fromDomain(e)).toList(),
      );
  GameInfo toDomain() => GameInfo(
      info: info.toDomain(),
      cheapestPriceEver: cheapestPriceEver.toDomain(),
      deals: deals.map((e) => e.toDomain()).toList());
}

@freezed
class GeneralInfoDto with _$GeneralInfoDto {
  const GeneralInfoDto._();
  const factory GeneralInfoDto(
      {required String title,
      required String? steamAppID,
      required String thumb}) = _GeneralInfoDto;
  factory GeneralInfoDto.fromJson(Map<String, dynamic> json) =>
      _$GeneralInfoDtoFromJson(json);
  factory GeneralInfoDto.fromDomain(GeneralInfo domain) => GeneralInfoDto(
        title: domain.title,
        steamAppID: domain.steamAppID,
        thumb: domain.thumb,
      );
  GeneralInfo toDomain() =>
      GeneralInfo(title: title, steamAppID: steamAppID, thumb: thumb);
}

@freezed
class CheapestPriceTimeDto with _$CheapestPriceTimeDto {
  const CheapestPriceTimeDto._();
  const factory CheapestPriceTimeDto({
    required String price,
    required int date,
  }) = _CheapestPriceTimeDto;

  factory CheapestPriceTimeDto.fromJson(Map<String, dynamic> json) =>
      _$CheapestPriceTimeDtoFromJson(json);
  factory CheapestPriceTimeDto.fromDomain(CheapestPriceTime domain) =>
      CheapestPriceTimeDto(
        price: domain.price,
        date: domain.date,
      );
  CheapestPriceTime toDomain() => CheapestPriceTime(price: price, date: date);
}

@freezed
class DealInfoDto with _$DealInfoDto {
  const DealInfoDto._();
  const factory DealInfoDto({
    required String storeID,
    required String dealID,
    required String price,
    required String retailPrice,
    required String savings,
  }) = _DealInfoDto;

  factory DealInfoDto.fromJson(Map<String, dynamic> json) =>
      _$DealInfoDtoFromJson(json);

  factory DealInfoDto.fromDomain(DealInfo domain) => DealInfoDto(
        storeID: domain.storeID,
        dealID: domain.dealID,
        price: domain.price,
        retailPrice: domain.retailPrice,
        savings: domain.savings,
      );

  DealInfo toDomain() => DealInfo(
      storeID: storeID,
      dealID: dealID,
      price: price,
      retailPrice: retailPrice,
      savings: savings);
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_deal/deals/core/domain/steam_prop.dart';

part 'steam_prop_dto.freezed.dart';
part 'steam_prop_dto.g.dart';

@freezed
class SteamPropDto with _$SteamPropDto {
  const SteamPropDto._();
  const factory SteamPropDto({
    required String? steamAppID,
    required String steamRatingCount,
    required String steamRatingPercent,
    required String? steamRatingText,
  }) = _SteamPropDto;

  factory SteamPropDto.fromJson(Map<String, dynamic> json) =>
      _$SteamPropDtoFromJson(json);

  factory SteamPropDto.fromDomain(SteamProp steamProp) => SteamPropDto(
        steamAppID: steamProp.steamAppID,
        steamRatingCount: steamProp.steamRatingCount,
        steamRatingPercent: steamProp.steamRatingPercent,
        steamRatingText: steamProp.steamRatingText,
      );

  SteamProp toDomain() => SteamProp(
        steamAppID: steamAppID,
        steamRatingCount: steamRatingCount,
        steamRatingPercent: steamRatingPercent,
        steamRatingText: steamRatingText,
      );
}

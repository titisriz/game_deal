import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_deal/deals/core/domain/detail_game_info.dart';
part 'detail_game_info_dto.freezed.dart';
part 'detail_game_info_dto.g.dart';

@freezed
class DetailGameInfoDto with _$DetailGameInfoDto {
  const DetailGameInfoDto._();
  const factory DetailGameInfoDto({
    required String storeID,
    required String gameID,
    required String name,
    required String? steamAppID,
    required String salePrice,
    required String retailPrice,
    required String? steamRatingText,
    required String steamRatingPercent,
    required String steamRatingCount,
    required String? metacriticScore,
    required String? metacriticLink,
    required int releaseDate,
    required String publisher,
    required String? steamworks,
    required String thumb,
  }) = _DetailGameInfoDto;

  factory DetailGameInfoDto.fromDomain(DetailGameInfo domain) =>
      DetailGameInfoDto(
        storeID: domain.storeID,
        gameID: domain.gameID,
        name: domain.name,
        steamAppID: domain.steamAppID,
        salePrice: domain.salePrice,
        retailPrice: domain.retailPrice,
        steamRatingText: domain.steamRatingText,
        steamRatingPercent: domain.steamRatingPercent,
        steamRatingCount: domain.steamRatingCount,
        metacriticScore: domain.metacriticScore,
        metacriticLink: domain.metacriticLink,
        releaseDate: domain.releaseDate,
        publisher: domain.publisher,
        steamworks: domain.steamworks,
        thumb: domain.thumb,
      );

  factory DetailGameInfoDto.fromJson(Map<String, dynamic> json) =>
      _$DetailGameInfoDtoFromJson(json);

  DetailGameInfo toDomain() => DetailGameInfo(
        storeID: storeID,
        gameID: gameID,
        name: name,
        steamAppID: steamAppID,
        salePrice: salePrice,
        retailPrice: retailPrice,
        steamRatingText: steamRatingText,
        steamRatingPercent: steamRatingPercent,
        steamRatingCount: steamRatingCount,
        metacriticScore: metacriticScore,
        metacriticLink: metacriticLink,
        releaseDate: releaseDate,
        publisher: publisher,
        steamworks: steamworks ?? "0",
        thumb: thumb,
      );
}

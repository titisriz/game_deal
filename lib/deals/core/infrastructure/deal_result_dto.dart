import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_deal/deals/core/domain/deal_result.dart';
import 'package:game_deal/deals/core/domain/metacritic_prop.dart';
import 'package:game_deal/deals/core/domain/steam_prop.dart';

part 'deal_result_dto.freezed.dart';
part 'deal_result_dto.g.dart';

@freezed
class DealResultDto with _$DealResultDto {
  const DealResultDto._();
  const factory DealResultDto({
    required String title,
    required String dealID,
    required String storeID,
    required String gameID,
    required String salePrice,
    required String normalPrice,
    required String savings,
    required int releaseDate,
    required String dealRating,
    required String thumb,
    required String? metacriticLink,
    required String? metacriticScore,
    required String? steamAppID,
    required String steamRatingCount,
    required String steamRatingPercent,
    required String? steamRatingText,
  }) = _DealResultDto;

  factory DealResultDto.fromJson(Map<String, dynamic> json) =>
      _$DealResultDtoFromJson(json);

  factory DealResultDto.fromDomain(DealResult res) => DealResultDto(
        title: res.title,
        dealID: res.dealID,
        storeID: res.storeID,
        gameID: res.gameID,
        salePrice: res.salePrice,
        normalPrice: res.normalPrice,
        savings: res.savings,
        releaseDate: res.releaseDate,
        dealRating: res.dealRating,
        thumb: res.thumb,
        metacriticLink: res.metaCriticProp.metacriticLink,
        metacriticScore: res.metaCriticProp.metacriticScore,
        steamAppID: res.steamProp.steamAppID,
        steamRatingCount: res.steamProp.steamRatingCount,
        steamRatingPercent: res.steamProp.steamRatingPercent,
        steamRatingText: res.steamProp.steamRatingText,
      );

  DealResult toDomain() => DealResult(
        title: title,
        dealID: dealID,
        storeID: storeID,
        gameID: gameID,
        salePrice: salePrice,
        normalPrice: normalPrice,
        savings: savings,
        releaseDate: releaseDate,
        dealRating: dealRating,
        thumb: thumb,
        metaCriticProp: MetaCriticProp(
          metacriticLink: metacriticLink,
          metacriticScore: metacriticScore,
        ),
        steamProp: SteamProp(
          steamAppID: steamAppID,
          steamRatingCount: steamRatingCount,
          steamRatingPercent: steamRatingPercent,
          steamRatingText: steamRatingText,
        ),
      );
}



/*
    "internalName": "DEUSEXHUMANREVOLUTIONDIRECTORSCUT",
    "title": "Deus Ex: Human Revolution - Director's Cut",
    "metacriticLink": "/game/pc/deus-ex-human-revolution---directors-cut",
    "dealID": "HhzMJAgQYGZ%2B%2BFPpBG%2BRFcuUQZJO3KXvlnyYYGwGUfU%3D",
    "storeID": "1",
    "gameID": "102249",
    "salePrice": "2.99",
    "normalPrice": "19.99",
    "isOnSale": "1",
    "savings": "85.042521",
    "metacriticScore": "91",
    "steamRatingText": "Very Positive",
    "steamRatingPercent": "92",
    "steamRatingCount": "17993",
    "steamAppID": "238010",
    "releaseDate": 1382400000,
    "lastChange": 1621536418,
    "dealRating": "9.6",
    "thumb": "https://cdn.cloudflare.steamstatic.com/steam/apps/238010/capsule_sm_120.jpg?t=1619788192"
*/

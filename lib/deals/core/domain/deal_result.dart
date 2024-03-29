import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_deal/deals/core/domain/metacritic_prop.dart';
import 'package:game_deal/deals/core/domain/steam_prop.dart';

part 'deal_result.freezed.dart';

@freezed
class DealResult with _$DealResult {
  const DealResult._();
  const factory DealResult({
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
    required MetaCriticProp metaCriticProp,
    required SteamProp steamProp,
  }) = _DealResult;

  String get rating {
    int steamRating = int.parse(steamProp.steamRatingPercent);
    return '${(steamRating / 10).toStringAsFixed(1)} /10';
  }

  String get dealSavings => '-${double.parse(savings).toStringAsFixed(0)}%';

  String get dealSalePrice => '\$$salePrice';

  String get dealNormalPrice => '\$$normalPrice';

  String get libraryImgUrl {
    return steamProp.steamAppID == null
        ? thumb
        : 'https://cdn.cloudflare.steamstatic.com/steam/apps/${steamProp.steamAppID}/library_600x900.jpg';
  }

  String get headerImgUrl {
    return steamProp.steamAppID == null
        ? thumb
        : 'https://cdn.cloudflare.steamstatic.com/steam/apps/${steamProp.steamAppID}/header.jpg';
  }

  String get libraryHeroImgUrl {
    return steamProp.steamAppID == null
        ? thumb
        : 'https://cdn.cloudflare.steamstatic.com/steam/apps/${steamProp.steamAppID}/library_hero.jpg';
  }
}

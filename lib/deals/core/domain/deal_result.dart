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

  int get steamRatingPercent {
    return int.parse(steamProp.steamRatingPercent);
  }

  String get steamRating {
    return '$steamRatingRounded /10';
  }

  String get steamRatingRounded {
    int steamRating = int.parse(steamProp.steamRatingPercent);
    return (steamRating / 10).toStringAsFixed(1);
  }

  int get metaCriticRatingPercent {
    return int.parse(metaCriticProp.metacriticScore ?? '0');
  }

  String get metaCriticRatingRounded {
    return (metaCriticRatingPercent / 10).toStringAsFixed(1);
  }

  String get metaCriticRating {
    return '${metaCriticProp.metacriticScore} /10';
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

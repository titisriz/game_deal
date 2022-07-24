import 'package:freezed_annotation/freezed_annotation.dart';
part 'detail_game_info.freezed.dart';

@freezed
class DetailGameInfo with _$DetailGameInfo {
  const DetailGameInfo._();
  const factory DetailGameInfo({
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
    required String steamworks,
    required String thumb,
  }) = _DetailGameInfo;
}

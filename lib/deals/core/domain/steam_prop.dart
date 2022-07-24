import 'package:freezed_annotation/freezed_annotation.dart';

part 'steam_prop.freezed.dart';

@freezed
class SteamProp with _$SteamProp {
  const SteamProp._();
  const factory SteamProp({
    required String? steamAppID,
    required String steamRatingCount,
    required String steamRatingPercent,
    required String? steamRatingText,
  }) = _SteamProp;
}

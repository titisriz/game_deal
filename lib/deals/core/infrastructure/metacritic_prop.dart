import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_deal/deals/core/domain/metacritic_prop.dart';
part 'metacritic_prop.freezed.dart';
part 'metacritic_prop.g.dart';

@freezed
class MetaCriticPropDto with _$MetaCriticPropDto {
  const MetaCriticPropDto._();
  const factory MetaCriticPropDto({
    required String? metacriticLink,
    required String? metacriticScore,
  }) = _MetaCriticPropDto;

  factory MetaCriticPropDto.fromJson(Map<String, dynamic> json) =>
      _$MetaCriticPropDtoFromJson(json);

  factory MetaCriticPropDto.fromDomain(MetaCriticProp prop) =>
      MetaCriticPropDto(
        metacriticLink: prop.metacriticLink,
        metacriticScore: prop.metacriticScore,
      );
  MetaCriticProp toDomain() => MetaCriticProp(
        metacriticLink: metacriticLink,
        metacriticScore: metacriticScore,
      );
}

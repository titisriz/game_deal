import 'package:freezed_annotation/freezed_annotation.dart';

part 'metacritic_prop.freezed.dart';

@freezed
class MetaCriticProp with _$MetaCriticProp {
  const MetaCriticProp._();
  const factory MetaCriticProp({
    String? metacriticLink,
    String? metacriticScore,
  }) = _MetaCriticProp;
}

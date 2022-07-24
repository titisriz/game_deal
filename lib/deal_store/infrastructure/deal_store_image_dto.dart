import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_deal/deal_store/domain/deal_store_image.dart';

part 'deal_store_image_dto.freezed.dart';
part 'deal_store_image_dto.g.dart';

@freezed
class DealStoreImageDto with _$DealStoreImageDto {
  const DealStoreImageDto._();
  const factory DealStoreImageDto({
    required String banner,
    required String logo,
    required String icon,
  }) = _DealStoreImageDto;

  factory DealStoreImageDto.fromJson(Map<String, dynamic> json) =>
      _$DealStoreImageDtoFromJson(json);

  factory DealStoreImageDto.fromDomain(DealStoreImage domain) =>
      DealStoreImageDto(
        banner: domain.banner,
        logo: domain.logo,
        icon: domain.icon,
      );
  DealStoreImage toDomain() => DealStoreImage(
        banner: banner,
        logo: logo,
        icon: icon,
      );
}

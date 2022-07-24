import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_deal/deal_store/domain/deal_store.dart';
import 'package:game_deal/deal_store/infrastructure/deal_store_image_dto.dart';
part 'deal_store_dto.freezed.dart';
part 'deal_store_dto.g.dart';

@freezed
class DealStoreDto with _$DealStoreDto {
  const DealStoreDto._();
  const factory DealStoreDto({
    required String storeID,
    required String storeName,
    required int isActive,
    required DealStoreImageDto images,
  }) = _DealStoreDto;

  factory DealStoreDto.fromJson(Map<String, dynamic> json) =>
      _$DealStoreDtoFromJson(json);

  factory DealStoreDto.fromDomain(DealStore domain) => DealStoreDto(
        storeID: domain.storeID,
        storeName: domain.storeName,
        isActive: domain.isActive,
        images: DealStoreImageDto.fromDomain(domain.images),
      );

  DealStore toDomain() => DealStore(
        storeID: storeID,
        storeName: storeName,
        isActive: isActive,
        images: images.toDomain(),
      );
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_deal/deals/core/domain/cheaper_store.dart';
part 'cheaper_store_dto.freezed.dart';
part 'cheaper_store_dto.g.dart';

@freezed
class CheaperStoreDto with _$CheaperStoreDto {
  const CheaperStoreDto._();
  const factory CheaperStoreDto({
    required String dealID,
    required String storeID,
    required String salePrice,
    required String retailPrice,
  }) = _CheaperStoreDto;

  factory CheaperStoreDto.fromDomain(CheaperStore domain) => CheaperStoreDto(
        dealID: domain.dealID,
        storeID: domain.storeID,
        salePrice: domain.salePrice,
        retailPrice: domain.retailPrice,
      );
  factory CheaperStoreDto.fromJson(Map<String, dynamic> json) =>
      _$CheaperStoreDtoFromJson(json);

  CheaperStore toDomain() => CheaperStore(
        dealID: dealID,
        storeID: storeID,
        salePrice: salePrice,
        retailPrice: retailPrice,
      );
}

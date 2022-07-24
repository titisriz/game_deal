import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_deal/deal_store/domain/deal_store_image.dart';
part 'deal_store.freezed.dart';

@freezed
class DealStore with _$DealStore {
  const factory DealStore({
    required String storeID,
    required String storeName,
    required int isActive,
    required DealStoreImage images,
  }) = _DealStore;
}

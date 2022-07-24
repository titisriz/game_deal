import 'package:freezed_annotation/freezed_annotation.dart';
part 'cheaper_store.freezed.dart';
@freezed
class CheaperStore with _$CheaperStore {
  const CheaperStore._();
  const factory CheaperStore({
    required String dealID,
    required String storeID,
    required String salePrice,
    required String retailPrice,
  }) = _CheaperStore;
}

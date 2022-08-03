import 'package:freezed_annotation/freezed_annotation.dart';
part 'game_info.freezed.dart';

@freezed
class GameInfo with _$GameInfo {
  const GameInfo._();
  const factory GameInfo({
    required GeneralInfo info,
    required CheapestPriceTime cheapestPriceEver,
    required List<DealInfo> deals,
  }) = _GameInfo;
}

@freezed
class GeneralInfo with _$GeneralInfo {
  const GeneralInfo._();
  const factory GeneralInfo(
      {required String title,
      required String? steamAppID,
      required String thumb}) = _GeneralInfo;
}

@freezed
class CheapestPriceTime with _$CheapestPriceTime {
  const CheapestPriceTime._();
  const factory CheapestPriceTime({
    required String price,
    required int date,
  }) = _CheapestPriceTime;
}

@freezed
class DealInfo with _$DealInfo {
  const DealInfo._();
  const factory DealInfo({
    required String storeID,
    required String dealID,
    required String price,
    required String retailPrice,
    required String savings,
  }) = _DealInfo;

  String get dealPercentage {
    final retail = double.parse(retailPrice);
    final discount = retail - double.parse(price);

    return '-${(discount / retail * 100).toStringAsFixed(0)}%';
  }
}

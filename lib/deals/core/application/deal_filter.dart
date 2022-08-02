import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/infrastructure/pagination_config.dart';

part 'deal_filter.g.dart';
part 'deal_filter.freezed.dart';

String? toStringJson(dynamic param) {
  return param?.toString();
}

@freezed
@JsonSerializable(includeIfNull: false)
class DealFilter with _$DealFilter {
  const DealFilter._();
  factory DealFilter({
    String? storeID, // radio / dropdown
    @JsonKey(toJson: toStringJson) required int pageNumber,
    @JsonKey(toJson: toStringJson) required int pageSize, //max 60
    String?
        sortBy, //radio / dropdown //Deal Rating + Title + Savings + Price + Metacritic + Reviews + Release + Store + recent
    @JsonKey(toJson: toStringJson) int? desc, //0/1
    @JsonKey(toJson: toStringJson)
        int? lowerPrice, //textinput //range similar with toped?
    @JsonKey(toJson: toStringJson) int? upperPrice, //textinput
    @JsonKey(toJson: toStringJson) int? metacritic,
    @JsonKey(toJson: toStringJson) int? steamRating, //slider
    String? steamAppID,
    String? title, //textinput
    @JsonKey(toJson: toStringJson) int? steamworks, //0/1
  }) = _DealFilter;

  factory DealFilter.baseFilter() =>
      DealFilter(pageNumber: 0, pageSize: dealPaginationSize);

  factory DealFilter.freeGameFilter() =>
      DealFilter(pageNumber: 0, pageSize: 10, lowerPrice: 0, upperPrice: 0);

  factory DealFilter.popularGameFilter() => DealFilter(
        pageNumber: 0,
        pageSize: 10,
        steamRating: 85,
        lowerPrice: 15,
      );
  factory DealFilter.dealByStore(String storeId) => DealFilter(
        pageNumber: 0,
        pageSize: 10,
        storeID: storeId,
      );

  factory DealFilter.mostRecentFilter() =>
      DealFilter(pageNumber: 0, pageSize: 10, sortBy: 'recent');

  @override
  Map<String, dynamic> toJson() => _$DealFilterToJson(this);
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_deal/core/infrastructure/pagination_config.dart';

part 'deal_filter.freezed.dart';

@freezed
class DealFilter with _$DealFilter {
  const DealFilter._();
  factory DealFilter({
    String? storeID, // radio / dropdown
    required int pageNumber,
    required int pageSize, //max 60
    String?
        sortBy, //radio / dropdown //Deal Rating + Title + Savings + Price + Metacritic + Reviews + Release + Store + recent
    int? desc, //0/1
    int? lowerPrice, //textinput //range similar with toped?
    int? upperPrice, //textinput
    int? metacritic,
    int? steamRating, //slider
    String? steamAppID,
    String? title, //textinput
    int? steamworks, //0/1
  }) = _DealFilter;

  factory DealFilter.baseFilter() =>
      DealFilter(pageNumber: 0, pageSize: dealPaginationSize);

  factory DealFilter.freeGameFilter() =>
      DealFilter(pageNumber: 0, pageSize: 10, lowerPrice: 0, upperPrice: 0);

  factory DealFilter.popularGameFilter() =>
      DealFilter(pageNumber: 0, pageSize: 10, steamRating: 85, lowerPrice: 15);

  factory DealFilter.mostRecentFilter() =>
      DealFilter(pageNumber: 0, pageSize: 10, sortBy: 'recent');
}

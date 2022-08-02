import 'package:game_deal/deals/core/application/deal_filter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FilterStateNotifier extends StateNotifier<DealFilter> {
  FilterStateNotifier() : super(DealFilter.baseFilter());

  void setFilter(DealFilter filter) {
    state = filter;
  }
}

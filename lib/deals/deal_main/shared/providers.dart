import 'package:game_deal/deals/core/application/deal_state_notifier.dart';
import 'package:game_deal/deals/core/shared/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final freeGamesStateNotifierProvider =
    StateNotifierProvider<DealStateNotifier, DealState>(
  (ref) {
    return DealStateNotifier(ref.watch(dealRepositoryProvider));
  },
);

//TODO : recent deals provider
final recentDealStateNotifierProvider =
    StateNotifierProvider<DealStateNotifier, DealState>(
  (ref) => DealStateNotifier(ref.watch(dealRepositoryProvider)),
);

//TODO : popular game deals provider
final popularDealStateNotifierProvider =
    StateNotifierProvider<DealStateNotifier, DealState>(
  (ref) => DealStateNotifier(ref.watch(dealRepositoryProvider)),
);

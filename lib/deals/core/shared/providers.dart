import 'package:game_deal/core/shared/providers.dart';
import 'package:game_deal/deals/core/application/deal_detail_state_notifier.dart';
import 'package:game_deal/deals/core/application/deal_state_notifier.dart';
import 'package:game_deal/deals/deal_search/application/form_filter_state.dart';
import 'package:game_deal/deals/core/application/browser_filter_state.dart';
import 'package:game_deal/deals/core/infrastructure/deal_remote_repository.dart';
import 'package:game_deal/deals/core/infrastructure/deal_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final dealRemoteRepositoryProvider = Provider(
  (ref) => DealRemoteRepository(
    ref.watch(dioProvider),
  ),
);

final dealRepositoryProvider = Provider(
  (ref) => DealRepository(
    ref.watch(dealRemoteRepositoryProvider),
  ),
);

final dealStateNotifierProvider =
    StateNotifierProvider<DealStateNotifier, DealState>(
  (ref) => DealStateNotifier(
    ref.watch(dealRepositoryProvider),
  ),
);

final browseFilterStateNotifierProvider =
    StateNotifierProvider<BrowserFilterStateNotifier, DealFilter>(
  (ref) {
    return BrowserFilterStateNotifier();
  },
);

final formFilterStateNotifierProvider =
    StateNotifierProvider.autoDispose<FormFilterStateNotifier, FormFilterState>(
  (ref) {
    return FormFilterStateNotifier();
  },
);

final dealDetailStateNotifier =
    StateNotifierProvider.autoDispose<DealDetailStateNotifier, DealDetailState>(
  (ref) => DealDetailStateNotifier(ref.watch(dealRepositoryProvider)),
);

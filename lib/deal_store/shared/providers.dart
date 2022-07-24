import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_deal/core/shared/providers.dart';
import 'package:game_deal/deal_store/application/deal_store_state_notifier.dart';
import 'package:game_deal/deal_store/domain/deal_store.dart';
import 'package:game_deal/deal_store/infrastructure/deal_store_local_repository.dart';
import 'package:game_deal/deal_store/infrastructure/deal_store_remote_repository.dart';
import 'package:game_deal/deal_store/infrastructure/deal_store_repository.dart';

final storeRemoteRepositoryProvider = Provider(
  (ref) => DealStoreRemoteRepository(ref.watch(dioProvider)),
);

final storeLocalRepositoryProvider = Provider(
  (ref) => DealStoreLocalRepository(ref.watch(sembastProvider)),
);

final dealStoreRepository = Provider(
  (ref) => DealStoreRepository(
    ref.watch(storeRemoteRepositoryProvider),
    ref.watch(storeLocalRepositoryProvider),
  ),
);

final dealStoreStateNotifier =
    StateNotifierProvider<DealStoreStateNotifier, DealStoreState>(
  (ref) => DealStoreStateNotifier(
    ref.watch(dealStoreRepository),
  ),
);

final activeStoreProvider = Provider<List<DealStore>>(
  (ref) {
    return ref
        .watch(dealStoreStateNotifier)
        .stores
        .where((element) => element.isActive == 1 ? true : false)
        .toList();
  },
);
final storeById = Provider.family<DealStore?, String>(
  (ref, storeId) =>
      ref.watch(dealStoreStateNotifier.notifier).getStore(storeId),
);

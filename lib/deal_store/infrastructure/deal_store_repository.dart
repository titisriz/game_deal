import 'package:dartz/dartz.dart';
import 'package:game_deal/core/domain/failures.dart';
import 'package:game_deal/core/infrastructure/rest_api_exception.dart';
import 'package:game_deal/deal_store/domain/deal_store.dart';
import 'package:game_deal/deal_store/infrastructure/deal_store_local_repository.dart';
import 'package:game_deal/deal_store/infrastructure/deal_store_remote_repository.dart';

class DealStoreRepository {
  final DealStoreRemoteRepository _dealStoreRemoteRepository;
  final DealStoreLocalRepository _dealStoreLocalRepository;
  DealStoreRepository(
    this._dealStoreRemoteRepository,
    this._dealStoreLocalRepository,
  );

  Future<Either<DealFailure, Unit>> getAndSaveStore() async {
    try {
      final dealStoreRemote = await _dealStoreRemoteRepository.getStores();
      return dealStoreRemote.map(
        noConnection: (_) async {
          final stores = await _dealStoreLocalRepository.getStores();
          if (stores.isEmpty) {
            return left(const DealFailure.apiFailure(errorCode: 0));
          }
          return right(unit);
        },
        withData: (_) async {
          _dealStoreLocalRepository.upsert(_.data);
          return right(unit);
        },
      );
    } on RestApiException catch (e) {
      return left(DealFailure.apiFailure(errorCode: e.errorCode));
    }
  }

  Future<List<DealStore>> getStores() async {
    final stores = await _dealStoreLocalRepository.getStores();
    if (stores.isEmpty) {
      getAndSaveStore();
    }
    return stores.map((e) => e.toDomain()).toList();
  }

  Future<DealStore?> getStore(String storeID) async {
    final dealStoreDto = await _dealStoreLocalRepository.getStore(storeID);
    return dealStoreDto?.toDomain();
  }
}

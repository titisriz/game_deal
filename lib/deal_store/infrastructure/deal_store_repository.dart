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

  Future<Either<DealFailure, List<DealStore>>> getAndSaveStore() async {
    try {
      final dealStoreRemote = await _dealStoreRemoteRepository.getStores();
      return dealStoreRemote.map(
        noConnection: (_) async {
          final stores = await _dealStoreLocalRepository.getStores();
          if (stores.isEmpty) {
            return left(const DealFailure.apiFailure(errorCode: 0));
          }
          return right(stores.map((e) => e.toDomain()).toList());
        },
        withData: (_) async {
          _dealStoreLocalRepository.upsert(_.data);
          return right(_.data.map((e) => e.toDomain()).toList());
        },
      );
    } on RestApiException catch (e) {
      return left(DealFailure.apiFailure(errorCode: e.errorCode));
    }
  }

  Future<Either<DealFailure, List<DealStore>>> getStores() async {
    final stores = await _dealStoreLocalRepository.getStores();
    if (stores.isEmpty) {
      return await getAndSaveStore();
    }
    return right(stores.map((e) => e.toDomain()).toList());
  }

  Future<DealStore?> getStore(String storeID) async {
    final dealStoreDto = await _dealStoreLocalRepository.getStore(storeID);
    return dealStoreDto?.toDomain();
  }
}

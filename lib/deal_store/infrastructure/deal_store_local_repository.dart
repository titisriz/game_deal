import 'package:game_deal/deal_store/infrastructure/deal_store_dto.dart';
import 'package:sembast/sembast.dart';

import 'package:game_deal/core/infrastructure/sembast_database.dart';

class DealStoreLocalRepository {
  final SembastDatabase _db;
  DealStoreLocalRepository(
    this._db,
  );
  final store = stringMapStoreFactory.store("dealStore");

  Future<void> upsert(List<DealStoreDto> storeDto) async {
    await store
        .records(
          storeDto.map((e) => e.storeID).toList(),
        )
        .put(
            _db.instance,
            storeDto.map((e) {
              Map<String, dynamic> json = e.toJson();
              return json;
            }).toList());
  }

  Future<List<DealStoreDto>> getStores() async {
    final dealStore = await store.find(_db.instance);
    return dealStore.map((e) {
      return DealStoreDto.fromJson(e.value);
    }).toList();
  }

  Future<DealStoreDto?> getStore(String storeID) async {
    final storeJson = await store.record(storeID).get(_db.instance);
    return storeJson == null ? null : DealStoreDto.fromJson(storeJson);
  }
}

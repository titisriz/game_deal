import 'package:game_deal/core/infrastructure/sembast_database.dart';
import 'package:game_deal/deals/core/domain/game_info.dart';
import 'package:sembast/sembast.dart';

class GameInfoLocalRepository {
  final SembastDatabase sembastDatabase;

  GameInfoLocalRepository(this.sembastDatabase);

  final storeGameIds = StoreRef<String, List<String>>('wishListedId');
  final storeGameInfos = StoreRef<String, List<GameInfo>>('wishListedId');
}

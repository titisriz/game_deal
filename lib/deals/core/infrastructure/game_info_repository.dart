import 'package:dartz/dartz.dart';
import 'package:game_deal/core/domain/failures.dart';
import 'package:game_deal/core/infrastructure/rest_api_exception.dart';
import 'package:game_deal/deals/core/domain/game_info.dart';
import 'package:game_deal/deals/core/infrastructure/game_info_remote_repository.dart';

class GameInfoRepository {
  final GameInfoRemoteRepository _gameInfoRemoteRepository;

  GameInfoRepository(this._gameInfoRemoteRepository);

  Future<Either<DealFailure, GameInfo?>> getInfo(String gameID) async {
    try {
      final response = await _gameInfoRemoteRepository.getInfo(gameID);
      return right(
        response.when(
          withData: (data) => data?.toDomain(),
          noConnection: () => null,
        ),
      );
    } on RestApiException catch (e) {
      return left(DealFailure.apiFailure(errorCode: e.errorCode));
    }
  }
}

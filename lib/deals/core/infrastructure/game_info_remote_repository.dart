import 'dart:io';

import 'package:dio/dio.dart';
import 'package:game_deal/deals/core/infrastructure/game_info_dto.dart';

import '../../../core/infrastructure/remote_response.dart';
import '../../../core/infrastructure/rest_api_exception.dart';

class GameInfoRemoteRepository {
  final Dio _dio;
  GameInfoRemoteRepository(this._dio);

  Future<RemoteResponse<GameInfoDto?>> getInfo(String gameId) async {
    try {
      final url =
          Uri.https('www.cheapshark.com', '/api/1.0/games', {'id': gameId});
      final response = await _dio.getUri(
        url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
      );
      final convertedData = GameInfoDto.fromJson(response.data);

      return RemoteResponse.withData(convertedData);
    } on DioError catch (e) {
      if (e.type == DioErrorType.other && e.error is SocketException) {
        return const RemoteResponse.noConnection();
      } else if (e.response != null) {
        throw RestApiException(errorCode: e.response!.statusCode);
      } else {
        rethrow;
      }
    }
  }
}

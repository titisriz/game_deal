import 'package:dio/dio.dart';
import 'package:game_deal/core/infrastructure/dio_extensions.dart';
import 'package:game_deal/core/infrastructure/remote_response.dart';
import 'package:game_deal/core/infrastructure/rest_api_exception.dart';
import 'package:game_deal/deal_store/infrastructure/deal_store_dto.dart';

class DealStoreRemoteRepository {
  final Dio _dio;

  DealStoreRemoteRepository(this._dio);

  Future<RemoteResponse<List<DealStoreDto>>> getStores() async {
    try {
      final url = Uri.https('www.cheapshark.com', '/api/1.0/stores');
      final response = await _dio.getUri(url);
      final convertedData = response.data as List<dynamic>;

      return RemoteResponse.withData(
          convertedData.map((e) => DealStoreDto.fromJson(e)).toList());
    } on DioError catch (e) {
      if (e.isNoConnectionError) {
        return const RemoteResponse.noConnection();
      } else if (e.response != null) {
        throw RestApiException(errorCode: e.response?.statusCode ?? 0);
      } else {
        rethrow;
      }
    }
  }
}

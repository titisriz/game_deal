import 'dart:io';

import 'package:dio/dio.dart';
import 'package:game_deal/core/domain/page.dart';
import 'package:game_deal/core/infrastructure/remote_response.dart';
import 'package:game_deal/core/infrastructure/rest_api_exception.dart';
import 'package:game_deal/deals/core/infrastructure/deal_detail_dto.dart';
import 'package:game_deal/deals/core/infrastructure/deal_result_dto.dart';

class DealRemoteRepository {
  final Dio _dio;

  DealRemoteRepository(this._dio);

  Future<RemoteResponse<Page<DealResultDto>>> getDeals(
      Map<String, dynamic> filter) async {
    try {
      final url = Uri.https('www.cheapshark.com', '/api/1.0/deals', filter);
      final response = await _dio.getUri(url);
      final maxPage = response.headers['x-total-page-count']?[0] ?? '0';
      final convertedData = response.data as List<dynamic>;

      return RemoteResponse.withData(
        Page(
          int.parse(filter['pageNumber']) < int.parse(maxPage),
          int.parse(maxPage),
          convertedData.map((e) => DealResultDto.fromJson(e)).toList(),
        ),
      );
    } on DioError catch (e) {
      if (e.type == DioErrorType.other && e.error is SocketException) {
        return const RemoteResponse.noConnection();
      } else if (e.response != null) {
        throw RestApiException(errorCode: e.response!.statusCode ?? 0);
      } else {
        rethrow;
      }
    }
  }

  Future<RemoteResponse<DealDetailDto>> getDetail(String id) async {
    final idParam = Uri.decodeFull(id);
    try {
      final url =
          Uri.https('www.cheapshark.com', '/api/1.0/deals', {'id': idParam});
      final response = await _dio.getUri(
        url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
      );
      final convertedData = DealDetailDto.fromJson(response.data);

      return RemoteResponse.withData(
        convertedData,
      );
    } on DioError catch (e) {
      if (e.type == DioErrorType.other && e.error is SocketException) {
        return const RemoteResponse.noConnection();
      } else if (e.response != null) {
        throw RestApiException(errorCode: e.response?.statusCode ?? 0);
      } else {
        rethrow;
      }
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:game_deal/core/domain/failures.dart';
import 'package:game_deal/core/domain/page.dart';
import 'package:game_deal/core/infrastructure/rest_api_exception.dart';
import 'package:game_deal/deals/core/domain/deal_detail.dart';
import 'package:game_deal/deals/core/domain/deal_result.dart';
import 'package:game_deal/deals/core/infrastructure/deal_remote_repository.dart';

class DealRepository {
  final DealRemoteRepository _remoteRepository;
  DealRepository(
    this._remoteRepository,
  );

  Future<Either<DealFailure, Page<DealResult>>> getDeals(
      Map<String, dynamic> filter) async {
    try {
      final response = await _remoteRepository.getDeals(filter);
      return right(
        response.when(
          withData: (dtoPage) => Page(
            dtoPage.isNextPageAvailable,
            dtoPage.totalPage,
            dtoPage.content.map((e) => e.toDomain()).toList(),
          ),
          noConnection: () => Page.empty(),
        ),
      );
    } on RestApiException catch (e) {
      return left(DealFailure.apiFailure(errorCode: e.errorCode));
    }
  }

  Future<Either<DealFailure, DealDetail?>> getDetail(String id) async {
    try {
      final response = await _remoteRepository.getDetail(id);
      return right(
        response.when(
          withData: (data) => data.toDomain(),
          noConnection: () => null,
        ),
      );
    } on RestApiException catch (e) {
      return left(DealFailure.apiFailure(errorCode: e.errorCode));
    }
  }
}

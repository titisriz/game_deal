import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
class DealFailure with _$DealFailure {
  const factory DealFailure.apiFailure({int? errorCode}) = _ApiFailure;
}

import 'dart:io';
import 'package:dio/dio.dart';

extension DioExtensions on DioError {
  bool get isNoConnectionError =>
      error.type == DioErrorType.other && error is SocketException;
}

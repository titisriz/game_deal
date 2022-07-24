class RestApiException implements Exception {
  int? errorCode;

  RestApiException({
    this.errorCode,
  });
}

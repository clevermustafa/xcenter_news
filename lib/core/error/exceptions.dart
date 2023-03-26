import 'package:dio/dio.dart';

class ServerException implements Exception {
  final String exceptionMessage;

  ServerException(this.exceptionMessage);
}

class UnknownException implements Exception {
  final String exceptionMessage;

  UnknownException(this.exceptionMessage);
}

class UnAuthorizedException implements Exception {
  final String exceptionMessage;
  UnAuthorizedException(this.exceptionMessage);
}

class BadRequestException implements Exception {
  final String exceptionMessage;
  BadRequestException(this.exceptionMessage);
}
class RequestExcededException implements Exception {
    final String exceptionMessage;
  RequestExcededException(this.exceptionMessage);
}

Exception throwException(Object e) {
  if (e is DioError) {
    if (e.response!.statusCode == 401) {
      throw UnAuthorizedException(e.response!.data!['message']!);
    } else if (e.response!.statusCode == 400) {
      throw BadRequestException(e.response!.data?['message'] ?? "Bad Request");
    } else if (e.response!.statusCode == 429) {
      throw RequestExcededException(e.response!.data?['message']);
    } else if (e.response!.statusCode == 500) {
      throw ServerException("Server Failure");
    } else {
      throw UnknownException(e.response!.data?['message']);
    }
  }else {
    throw UnknownException(e.toString());
  }
}

import 'package:xcenter_news/core/error/exceptions.dart';

abstract class Failure {
  String failureMessage;

  Failure(this.failureMessage);
}



///server responds but not expected
class ServerFailure extends Failure {
  ServerFailure({String message = "Server Failure"}) : super(message);
}



///NetworkFailure
class NetworkFailure extends Failure {
  NetworkFailure({String failureMessage = "No Internet Connection"})
      : super(failureMessage);
}

///Bad request failure
class BadRequestFailure extends Failure {
  BadRequestFailure({String failureMessage = "Bad Request"})
      : super(failureMessage);
}
///Unauthorized failure
class UnAuthorizedFailure extends Failure {
  UnAuthorizedFailure({String failureMessage = "Unauthorized"})
      : super(failureMessage);
}

class RequestExcededFailure extends Failure {
  RequestExcededFailure({String failureMessage = "Request Exceded"})
      : super(failureMessage);
}

///anything else
class UnknownFailure extends Failure {
  UnknownFailure({String failureMessage = "Failed"})
      : super(failureMessage);
}

Failure parseFailure(Object e) {

  if (e is ServerException) {
    return ServerFailure();
  
  } else if (e is BadRequestException) {
    return BadRequestFailure();
  } else if (e is UnAuthorizedException) {
    return UnAuthorizedFailure(failureMessage: e.exceptionMessage);
  } else if (e is RequestExcededException) {
    return RequestExcededFailure(failureMessage: e.exceptionMessage);
  } else {
    return UnknownFailure();
  }
}



import 'package:equatable/equatable.dart';
import 'package:parkingslot/src/core/errors/exceptions.dart';

abstract class Failure extends Equatable {
  final String errorMessage;
  final int statusCode;

  const Failure({required this.errorMessage, required this.statusCode});

  String get errorMsg => '$statusCode , Error : $errorMessage';

  @override
  List<Object> get props => [errorMessage, statusCode];
}

class ApiFailure extends Failure {
  const ApiFailure({required super.errorMessage, required super.statusCode});

   ApiFailure.fromException(APIException apiException):this( errorMessage: apiException.message,statusCode: apiException.statusCode);
}

class LocalFailure extends Failure {
  const LocalFailure({required super.errorMessage, required super.statusCode});

  LocalFailure.fromException(LocalException localException):this( errorMessage: localException.message,statusCode: localException.statusCode);
}



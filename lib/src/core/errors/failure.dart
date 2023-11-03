import 'package:equatable/equatable.dart';
import 'package:parkingslot/src/core/errors/exceptions.dart';

abstract class Failure extends Equatable {
  final String errorMessage;
  final int statusCode;

  const Failure({required this.errorMessage, required this.statusCode});

  @override
  List<Object> get props => [errorMessage, statusCode];
}

class LocalFailure extends Failure {
  const LocalFailure({required super.errorMessage, required super.statusCode});

  LocalFailure.fromException(LocalException localException) : this(errorMessage: localException.message, statusCode: localException.statusCode);
}

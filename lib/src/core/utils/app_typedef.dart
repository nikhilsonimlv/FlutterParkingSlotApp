import 'package:dartz/dartz.dart';
import 'package:parkingslot/src/core/errors/failure.dart';

typedef ResultingFuture<T> = Future<Either<Failure, T>>;
typedef ResultingVoid = ResultingFuture<void>;
typedef DataMap = Map<String, dynamic>;

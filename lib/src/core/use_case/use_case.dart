import 'package:parkingslot/src/core/utils/app_typedef.dart';

abstract class UseCaseWithParameter<Type, Parameters> {
  ResultingFuture<Type> call(Parameters parameters);

  const UseCaseWithParameter();
}

abstract class UseCaseWithOutParameter<Type> {
  ResultingFuture<Type> call();

  const UseCaseWithOutParameter();
}

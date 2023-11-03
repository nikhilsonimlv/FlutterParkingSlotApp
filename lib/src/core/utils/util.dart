import 'package:dartz/dartz.dart';

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map) : reverseMap = map.map((k, v) => MapEntry(v, k));

  Map<T, String> get reverse {
    return reverseMap;
  }
}


extension EitherX<L, R> on Either<L, R> {
  R asRight() => (this as Right).value; //
  L asLeft() => (this as Left).value;
}

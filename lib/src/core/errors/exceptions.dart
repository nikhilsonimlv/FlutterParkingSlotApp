import 'package:equatable/equatable.dart';

class LocalException  implements Exception{
  final String message;
  final int  statusCode;

  const LocalException.name({required this.message, required this.statusCode});

}



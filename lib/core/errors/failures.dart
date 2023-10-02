import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

// General Failures
class CacheFailure extends Failure {}

class ServerFailure extends Failure {}

class UnknownFailure extends Failure {}

class InvalidInputFailure extends Failure {}

class NetworkFailure extends Failure {}

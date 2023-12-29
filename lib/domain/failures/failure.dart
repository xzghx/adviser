import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class CacheFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class GeneralFailure extends Failure {
  @override
  List<Object?> get props => [];
}

extension FailureExtension on Failure {
  String getMessage() {
    switch (runtimeType) {
      case ServerFailure:
        return 'Server error. please try later';
      case CacheFailure:
        return 'Some error on cache occurred. please try later';
      default:
        return 'something went wrong. please try later';
    }
  }
}

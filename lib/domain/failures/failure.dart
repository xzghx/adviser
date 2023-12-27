abstract class Failure {}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class GeneralFailure extends Failure {}

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

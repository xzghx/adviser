import 'package:advicer_app/domain/entities/advise_entity.dart';
import 'package:advicer_app/domain/failures/failure.dart';
import 'package:dartz/dartz.dart';

class AdviseUseCase {
  Future<Either<Failure, AdviseEntity>> getAdvice() async {
    await Future.delayed(const Duration(seconds: 1));
    return right(const AdviseEntity(id: 1, advise: 'Test advice'));
    // return left(ServerFailure());
  }
}

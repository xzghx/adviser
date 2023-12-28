import 'package:advicer_app/domain/entities/advise_entity.dart';
import 'package:advicer_app/domain/failures/failure.dart';
import 'package:advicer_app/domain/repositories/advise_repo.dart';
import 'package:dartz/dartz.dart';

class AdviseUseCase {
  final AdviseRepo adviseRepo;

  AdviseUseCase({required this.adviseRepo});

  Future<Either<Failure, AdviseEntity>> getAdvice() async {
    //here you can do some operations on the received data before returning it
    return adviseRepo.getAdvise();
  }
}

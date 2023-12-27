import 'package:advicer_app/domain/entities/advise_entity.dart';
import 'package:dartz/dartz.dart';

import '../failures/failure.dart';

abstract class AdviseRepo {
  Future<Either<Failure, AdviseEntity>> getAdvise();
}

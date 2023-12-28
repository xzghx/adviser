import 'package:advicer_app/data/data_sources/advise_remote_data_source.dart';
import 'package:advicer_app/domain/entities/advise_entity.dart';
import 'package:advicer_app/domain/failures/failure.dart';
import 'package:advicer_app/domain/repositories/advise_repo.dart';
import 'package:dartz/dartz.dart';

import '../exceptions/exceptions.dart';

class AdviseRepoImpl implements AdviseRepo {
  AdviseRepoImpl({required this.remoteDataSource});

  final AdviseRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, AdviseEntity>> getAdvise() async {
    try {
      final adviceModel = await remoteDataSource.getRandomAdvice();
      return right(adviceModel);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      return left(GeneralFailure());
    }
  }
}

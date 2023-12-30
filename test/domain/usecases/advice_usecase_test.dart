import 'package:advicer_app/data/repositories/advise_repo_impl.dart';
import 'package:advicer_app/domain/entities/advise_entity.dart';
import 'package:advicer_app/domain/failures/failure.dart';
import 'package:advicer_app/domain/usecases/advice_usecases.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'advice_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AdviseRepoImpl>()])
void main() {
  group('Advise UseCases', () {
    //Good Case
    group('should return Right with', () {
      test('Should return AdviseEntity', () async {
        final MockAdviseRepoImpl mockAdviseRepo = MockAdviseRepoImpl();
        final AdviseUseCase adviseUseCaseUnderTest =
            AdviseUseCase(adviseRepo: mockAdviseRepo);
        //
        when(mockAdviseRepo.getAdvise()).thenAnswer((_) => Future.value(
            const Right(AdviseEntity(advise: 'test text', id: 1))));
        //
        final Either<Failure, AdviseEntity> result =
            await adviseUseCaseUnderTest.getAdvice();
        expect(result.isRight(), true);
        expect(result.isLeft(), false);
        expect(
            result,
            const Right<Failure, AdviseEntity>(
                AdviseEntity(advise: 'test text', id: 1)));
        verify(mockAdviseRepo.getAdvise()).called(1);
        verifyNoMoreInteractions(mockAdviseRepo);
      });
    });
    //Bad Case - ServerFailure
    group('Should return Left with', () {
      test('Should  return ServerFailure', () async {
        final mockAdviseRepoImpl = MockAdviseRepoImpl();
        final adviseUsecaseUnderTest =
            AdviseUseCase(adviseRepo: mockAdviseRepoImpl);
        //
        when(mockAdviseRepoImpl.getAdvise()).thenAnswer(
            (realInvocation) => Future.value(Left(ServerFailure())));
        //

        final result = await adviseUsecaseUnderTest.getAdvice();
        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, AdviseEntity>(ServerFailure()));
        verify(mockAdviseRepoImpl.getAdvise()).called(1);
        verifyNoMoreInteractions(mockAdviseRepoImpl);
      });
    });

    //Bad Case - GeneralFailure
    group('Should return Left with', () {
      test('Should  return GeneralFailure', () async {
        final mockAdviseRepoImpl = MockAdviseRepoImpl();
        final adviseUsecaseUnderTest =
            AdviseUseCase(adviseRepo: mockAdviseRepoImpl);
        //
        when(mockAdviseRepoImpl.getAdvise()).thenAnswer(
            (realInvocation) => Future.value(Left(GeneralFailure())));
        //

        final result = await adviseUsecaseUnderTest.getAdvice();
        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, AdviseEntity>(GeneralFailure()));
        verify(mockAdviseRepoImpl.getAdvise()).called(1);
        // verifyNever(); use [verifyNever]  if 0 is for called(0) is what you want
        verifyNoMoreInteractions(mockAdviseRepoImpl);
      });
    });
  });
}

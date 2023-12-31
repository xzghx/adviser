import 'package:advicer_app/application/pages/advice/cubit/advicer_cubit.dart';
import 'package:advicer_app/domain/entities/advise_entity.dart';
import 'package:advicer_app/domain/failures/failure.dart';
import 'package:advicer_app/domain/usecases/advice_usecases.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockAdviseUseCase extends Mock implements AdviseUseCase {}

void main() {
  group('adviserCubit', () {
    group('should emit ', () {
      final mockAdviseUseCase = MockAdviseUseCase();
      //
      blocTest(
        'nothing when no event is added',
        build: () => AdvicerCubit(adviseUseCase: mockAdviseUseCase),
        expect: () => <AdviserState>[],
      );
      //
      blocTest(
        '[LoadingState , LoadedState]',
        build: () => AdvicerCubit(adviseUseCase: mockAdviseUseCase),
        setUp: () => when(() => mockAdviseUseCase.getAdvice()).thenAnswer(
          (_) => Future.value(
            const Right<Failure, AdviseEntity>(
              AdviseEntity(id: 1, advise: 'fake advisee'),
            ),
          ),
        ),
        act: (cubit) => cubit.adviceRequest(),
        expect: () => <AdviserState>[
          AdviserLoading(),
          AdviserLoaded(advice: 'fake advisee')
        ],
      );
      //
      group('Should emit ErrorState on adviceRequest event', () {
        blocTest(
          'and a ServerFailure',
          build: () => AdvicerCubit(adviseUseCase: mockAdviseUseCase),
          setUp: () => when(() => mockAdviseUseCase.getAdvice()).thenAnswer(
            (invocation) =>
                Future.value(Left<Failure, AdviseEntity>(ServerFailure())),
          ),
          act: (cubit) => cubit.adviceRequest(),
          expect: () => <AdviserState>[
            AdviserLoading(),
            AdviserError(error: ServerFailure().getMessage())
          ],
        );

        blocTest(
          'and a Cache Failure',
          build: () => AdvicerCubit(adviseUseCase: mockAdviseUseCase),
          setUp: () => when(() => mockAdviseUseCase.getAdvice()).thenAnswer(
            (invocation) =>
                Future.value(Left<Failure, AdviseEntity>(CacheFailure())),
          ),
          act: (cubit) => cubit.adviceRequest(),
          expect: () => <AdviserState>[
            AdviserLoading(),
            AdviserError(error: CacheFailure().getMessage())
          ],
        );

        blocTest(
          'and a General Failure',
          build: () => AdvicerCubit(adviseUseCase: mockAdviseUseCase),
          setUp: () => when(() => mockAdviseUseCase.getAdvice()).thenAnswer(
            (invocation) =>
                Future.value(Left<Failure, AdviseEntity>(GeneralFailure())),
          ),
          act: (cubit) => cubit.adviceRequest(),
          expect: () => <AdviserState>[
            AdviserLoading(),
            AdviserError(error: GeneralFailure().getMessage())
          ],
        );
      });
    });
  });
}

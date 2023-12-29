import 'dart:io';

import 'package:advicer_app/data/data_sources/advise_remote_data_source.dart';
import 'package:advicer_app/data/exceptions/exceptions.dart';
import 'package:advicer_app/data/models/advise_model.dart';
import 'package:advicer_app/data/repositories/advise_repo_impl.dart';
import 'package:advicer_app/domain/failures/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'advise_repo_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AdviseRemoteDataSourceImpl>()])
main() {
  group('Advise Repo Impl', () {
    //Right
    group('should return Right with AdviseEntity', () {
      test('when remote data source returns an AdviceModel', () async {
        //First mock the data source since we have tested it before
        final mockDataSource = MockAdviseRemoteDataSourceImpl();

        final adviseRepoImplUnderTest =
            AdviseRepoImpl(remoteDataSource: mockDataSource);

        when(
          mockDataSource.getRandomAdvice(),
        ).thenAnswer((realInvocation) =>
            Future.value(AdviseModel(advise: 'testAdvise', id: 22)));

        final result = await adviseRepoImplUnderTest.getAdvise();

        expect(result.isLeft(), false);
        expect(result.isRight(), true);
        verify(mockDataSource.getRandomAdvice()).called(1);
        verifyNoMoreInteractions(mockDataSource);
      });
    });
    //Left
    group('should return left', () {
      //
      test('with ServerFailure when serverException', () async {
        final mockDataSource = MockAdviseRemoteDataSourceImpl();
        final adviseRepoImplUnderTest =
            AdviseRepoImpl(remoteDataSource: mockDataSource);

        when(mockDataSource.getRandomAdvice()).thenThrow(ServerException());

        final result = await adviseRepoImplUnderTest.getAdvise();

        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, AdviseModel>(ServerFailure()));
      });
      //
      test('with GeneralFailure when other Exceptions happen', () async {
        final mockDataSource = MockAdviseRemoteDataSourceImpl();
        final adviseRepoImplUnderTest =
            AdviseRepoImpl(remoteDataSource: mockDataSource);

        when(mockDataSource.getRandomAdvice())
            .thenThrow(const SocketException('test SocketException message!'));

        final result = await adviseRepoImplUnderTest.getAdvise();

        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, AdviseModel>(GeneralFailure()));
      });
    });
  });
}

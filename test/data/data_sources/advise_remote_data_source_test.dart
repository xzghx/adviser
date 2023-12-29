import 'package:advicer_app/data/data_sources/advise_remote_data_source.dart';
import 'package:advicer_app/data/exceptions/exceptions.dart';
import 'package:advicer_app/data/models/advise_model.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'advise_remote_data_source_test.mocks.dart';

//Unit Testing
@GenerateNiceMocks([MockSpec<Client>()])
void main() {
  group(
    'AdviceRemoteDataSource',
    () {
      final MockClient mockClient = MockClient();

      final adviceRemoteDataSourceUnderTest =
          AdviseRemoteDataSourceImpl(client: mockClient);
      //test 200 status code
      group('Should return AdviceModel', () {
        test('When status 200, should have data', () async {
          const responseBody = '{"advice" :"Test advice" ,"advice_id":1 }';

          when(mockClient.get(
            Uri.parse('https://api.flutter-community.com/api/v1/advice'),
            headers: {'content-type': 'application/json'},
          )).thenAnswer(
            (_) => Future.value(Response(responseBody, 200)),
          );
          // The "stub" is the mock method response
          final AdviseModel result =
              await adviceRemoteDataSourceUnderTest.getRandomAdvice();
          expect(result, AdviseModel(id: 1, advise: 'Test advice'));
        });
      });
      //test exception
      group('Should Throw a', () {
        test(' ServerException for status code other than 200', () async {
          when(
            mockClient.get(
              Uri.parse('https://api.flutter-community.com/api/v1/advice'),
              headers: {'content-type': 'application/json'},
            ),
          ).thenAnswer((realInvocation) => Future.value(Response('', 201)));

          final result = adviceRemoteDataSourceUnderTest.getRandomAdvice();
          expect(result, throwsA(isA<ServerException>()));
        });
      });
      //test json mismatch
      group('a type error for status code 200 and not json data is not valid',
          () {
        test('When invalid json response,show typeError', () async {
          //advice_id is missing
          const reponseBody = '{"advice":"Test Advice"}';

          when(mockClient.get(
            Uri.parse('https://api.flutter-community.com/api/v1/advice'),
            headers: {'content-type': 'application/json'},
          )).thenAnswer(
              (realInvocation) => Future.value(Response(reponseBody, 200)));

          // final result =
          //     await adviceRemoteDataSourceUnderTest.getRandomAdvice();

          expect(
              () async =>
                  await adviceRemoteDataSourceUnderTest.getRandomAdvice(),
              throwsA(isA<TypeError>()));
        });
      });
    },
  );
}

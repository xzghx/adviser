import 'package:advicer_app/application/pages/advice/bloc/advicer_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:test/test.dart';

void main() {
  //'emits loading state and then error state when  adviceRequest event is added'
  group('Adviser Bloc', () {
    blocTest<AdviserBloc, AdviserState>(
      'emits nothing when no event is added',
      build: () => AdviserBloc(),
      // nothing here since we want to have no event
      act: (bloc) {},
      //here should be empty so no event and no state.
      expect: () => <AdviserState>[],
    );

    blocTest<AdviserBloc, AdviserState>(
      'emits nothing when no event is added',
      build: () => AdviserBloc(),
      act: (bloc) => bloc.add(AdviceRequest()),
      wait: const Duration(seconds: 1),
      expect: () =>
          <AdviserState>[AdviserLoading(), AdviserError(error: 'Fake error')],
    );
  });
}

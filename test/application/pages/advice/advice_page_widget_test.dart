import 'package:advicer_app/application/core/services/theme_service.dart';
import 'package:advicer_app/application/pages/advice/advice_page.dart';
import 'package:advicer_app/application/pages/advice/cubit/advicer_cubit.dart';
import 'package:advicer_app/application/pages/advice/widgets/advise_field.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

class MockAdviseCubit extends MockCubit<AdviserState> implements AdvicerCubit {}

void main() {
  Widget widgetUnderTest(AdvicerCubit advicerCubit) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => ThemeService(),
        child: BlocProvider(
          create: (context) => advicerCubit,
          child: const AdvicePage(),
        ),
      ),
    );
  }

  group('AdvicePage', () {
    late final MockAdviseCubit mockCubit;

    setUp(() {
      mockCubit = MockAdviseCubit();
    });

    group('should be displayed in viewState', () {
      testWidgets('display initial  for InitialState', (widgetTester) async {
        whenListen(
          mockCubit,
          Stream.fromIterable(
            const [AdviserInitial()],
          ),
          initialState: const AdviserInitial(),
        );
        await widgetTester.pumpWidget(widgetUnderTest(mockCubit));
        //
        final textFinder = find.textContaining('Let see an advice!');
        expect(textFinder, findsOneWidget);
      });
      //
      testWidgets('loading  for LoadingState', (widgetTester) async {
        whenListen(
          mockCubit,
          Stream.fromIterable(
            const [AdviserLoading()],
          ),
          initialState: const AdviserInitial(),
        );
        await widgetTester.pumpWidget(widgetUnderTest(mockCubit));
        //insure that progressIndicator is pumped. because it has animations.
        //***** pumpAndSettle will not work here because  progressIndicator is never settle
        await widgetTester.pump();
        //
        final progressFinder = find.byType(CircularProgressIndicator);
        expect(progressFinder, findsOneWidget);
      });
      //

      testWidgets('Loaded when LoadedState', (widgetTester) async {
        whenListen(
          mockCubit,
          Stream.fromIterable(
            const [AdviserLoaded(advice: 'test advice')],
          ),
          initialState: const AdviserInitial(),
        );

        await widgetTester.pumpWidget(widgetUnderTest(mockCubit));
        //we need to wait for pump since there is a little bit time between initial state and loaded state
        await widgetTester.pump();

        final adviceFieldFinder = find.byType(AdviceField);
        final textFinder = find.textContaining('test advice');
        final adviceText =
            widgetTester.widget<AdviceField>(find.byType(AdviceField)).advice;
        expect(textFinder, findsOneWidget);
        expect(adviceFieldFinder, findsOneWidget);
        expect(adviceText, 'test advice');
      });
      //
      testWidgets('Error when AdviseError state is emitted',
          (widgetTester) async {
        whenListen(
          mockCubit,
          Stream.fromIterable(
              const [AdviserError(error: 'test error message')]),
          initialState: const AdviserInitial(),
        );

        await widgetTester.pumpWidget(widgetUnderTest(mockCubit));
        await widgetTester.pump();

        final adviceErrorText =
            widgetTester.widget<AdviceError>(find.byType(AdviceError)).error;
        expect(adviceErrorText, 'test error message');

        final adviceErrorFinder = find.byType(AdviceError);
        expect(adviceErrorFinder, findsOneWidget);
      });
      //
    });
  });
}

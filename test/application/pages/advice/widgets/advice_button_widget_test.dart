import 'package:advicer_app/application/pages/advice/widgets/advice_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

abstract class AdviceOnTap {
  void call();
}

//to mock the on button click or tap
class MockAdviceOnTap extends Mock implements AdviceOnTap {}

void main() {
  Widget getWidgetUnderTest({Function()? onTap}) {
    return MaterialApp(
      home: Scaffold(
        body: AdviceButton(onTap: onTap),
      ),
    );
  }

  group('AdviceButton', () {
    group('Renders a AdviceButton ', () {
      testWidgets('and should display label', (widgetTester) async {
        await widgetTester.pumpWidget(getWidgetUnderTest());

        final btnLabelFinder = find.text('Get Advice');
        expect(btnLabelFinder, findsOneWidget);
      });
    });

    group('and should handle onPress', () {
      testWidgets('when onPress is fired', (widgetTester) async {
        final mockOnTap = MockAdviceOnTap();
        await widgetTester.pumpWidget(getWidgetUnderTest(onTap: mockOnTap));

        final btnFinder = find.byType(AdviceButton);

        await widgetTester.tap(btnFinder);
        await widgetTester.tap(btnFinder);

        //mocktail syntax
        verify(() => mockOnTap()).called(2);
        //mockito syntax
        // verify( mockOnTap()).called(1);
      });
    });
  });
}

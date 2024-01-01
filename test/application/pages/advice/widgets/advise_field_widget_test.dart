import 'package:advicer_app/application/pages/advice/widgets/advise_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget getAdviseField(String text) {
    return MaterialApp(
      home: AdviceField(
        advice: text,
      ),
    );
  }

  group('AdviseField', () {
    group('Should display correctly', () {
      //
      testWidgets('for short text', (widgetTester) async {
        const text = 'a';
        await widgetTester.pumpWidget(getAdviseField(text));
        await widgetTester.pumpAndSettle();

        final adviseFieldFinder = find.textContaining(text);
        expect(adviseFieldFinder, findsOneWidget);
      });
      //
      testWidgets('for long text', (widgetTester) async {
        const text =
            'Hello.................. here a very very long text is going to be shown as advise just for testing  a text widget. this text is very very very long.......';
        await widgetTester.pumpWidget(getAdviseField(text));
        await widgetTester.pumpAndSettle();

        final adviseFieldFinder = find.byType(AdviceField);
        expect(adviseFieldFinder, findsOneWidget);
      });
      //
      testWidgets('when no text is given', (widgetTester) async {
        const text = '';
        await widgetTester.pumpWidget(getAdviseField(text));
        await widgetTester.pumpAndSettle();

        final adviseFieldFinder = find.text(AdviceField.emptyString);
        expect(adviseFieldFinder, findsOneWidget);

        final String advice =
            widgetTester.widget<AdviceField>(find.byType(AdviceField)).advice;
        expect(advice, text);
      });
    });
  });
}

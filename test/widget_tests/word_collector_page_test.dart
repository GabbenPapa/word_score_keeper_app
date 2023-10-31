import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:word_score_keeper_app/src/components/buttons.dart';
import 'package:word_score_keeper_app/src/components/text_inputfield.dart';
import 'package:word_score_keeper_app/src/pages/word_collector_page.dart';
import 'package:word_score_keeper_app/src/bloc/word_list_bloc.dart';

void main() {
  group('WordCollectorPage tests', () {
    Widget createWidgetUnderTest() {
      return MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<WordListBloc>(
              create: (context) => WordListBloc(),
            ),
          ],
          child: const WordCollectorPage(),
        ),
      );
    }

    testWidgets('Check add to list button', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      final addButton = find.text('Add to List');
      final inputField = find.byType(TextInputField);

      expect(addButton, findsOneWidget);
      expect(inputField, findsOneWidget);

      await tester.enterText(inputField, 'Griffin');
      await tester.tap(addButton);
      await tester.pump();

      expect(find.text('Griffin'), findsOneWidget);
    });

    testWidgets('Check add button behavior with empty input',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      final addButton = find.text('Add to List');
      final inputField = find.byType(TextInputField);
      final mainButton =
          find.byType(MainButton).evaluate().single.widget as MainButton;

      expect(addButton, findsOneWidget);
      expect(inputField, findsOneWidget);

      await tester.tap(addButton);
      await tester.pumpAndSettle();

      expect(mainButton.enabled, isFalse);
    });
  });
}

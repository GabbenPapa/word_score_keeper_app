import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:word_score_keeper_app/src/pages/word_score_page.dart';
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
          child: const CollectedWordsPage(),
        ),
      );
    }

    testWidgets('Emtpy text on score view', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(
          find.text('There is no element added to the List'), findsOneWidget);
    });

    testWidgets('Accumulated Score', (WidgetTester tester) async {
      final wordListBloc = WordListBloc();
      wordListBloc.add(AddTextToListEvent(text: 'Griffin'));
      wordListBloc.add(AddTextToListEvent(text: 'Quagmire'));
      wordListBloc.add(AddTextToListEvent(text: 'Brown'));
      wordListBloc.add(AddTextToListEvent(text: 'Swanson'));

      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<WordListBloc>.value(value: wordListBloc),
            ],
            child: const CollectedWordsPage(),
          ),
        ),
      );

      expect(find.text('Accumulated Score:'), findsOneWidget);
      expect(find.text('27'), findsOneWidget);
    });
  });
}

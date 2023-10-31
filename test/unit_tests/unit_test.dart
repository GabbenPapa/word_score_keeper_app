import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:word_score_keeper_app/src/bloc/word_list_bloc.dart';

void main() {
  group('WordListBloc', () {
    late WordListBloc wordListBloc;

    setUp(() {
      wordListBloc = WordListBloc();
    });

    tearDown(() {
      wordListBloc.close();
    });

    test('initial state is InitialState', () {
      expect(wordListBloc.state, isA<InitialState>());
    });

    blocTest<WordListBloc, WordListStates>(
      'Added an empty string',
      build: () => wordListBloc,
      act: (wordListBloc) => wordListBloc.add(AddTextToListEvent(text: '')),
      expect: () => [],
    );

    blocTest<WordListBloc, WordListStates>(
      'Add a string to the list',
      build: () => wordListBloc,
      seed: () => UpdateState({'Griffin'}, 7),
      act: (bloc) => bloc.add(AddTextToListEvent(text: 'Griffin')),
      expect: () => [
        isA<UpdateState>().having((updateState) => updateState.collectedWords,
            'collectedWords', contains('Griffin')),
      ],
    );

    blocTest<WordListBloc, WordListStates>(
      'Check total score value for a sinlge string',
      build: () => wordListBloc,
      seed: () => UpdateState({'Griffin'}, 7),
      act: (bloc) => bloc.add(AddTextToListEvent(text: 'Griffin')),
      expect: () => [
        isA<UpdateState>().having(
            (updateState) => updateState.totalCharacterCount,
            'totalCharacterCount',
            'Griffin'.length),
      ],
    );

    blocTest<WordListBloc, WordListStates>(
      'Add multiple string to the list',
      build: () => wordListBloc,
      act: (bloc) {
        bloc.add(AddTextToListEvent(text: 'Quagmire'));
        bloc.add(AddTextToListEvent(text: 'Swanson'));
        bloc.add(AddTextToListEvent(text: 'Brown'));
      },
      expect: () {
        return [
          isA<UpdateState>().having((updateState) => updateState.collectedWords,
              'collectedWords', contains('Quagmire')),
          isA<UpdateState>().having((updateState) => updateState.collectedWords,
              'collectedWords', contains('Swanson')),
          isA<UpdateState>().having((updateState) => updateState.collectedWords,
              'collectedWords', contains('Brown')),
        ];
      },
      verify: (bloc) {
        expect(bloc.state, isA<UpdateState>());
        final updateState = bloc.state as UpdateState;
        expect(updateState.collectedWords.length, 3);
      },
    );
  });
}

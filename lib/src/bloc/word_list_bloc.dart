import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'word_list_event_bloc.dart';
part 'word_list_state_bloc.dart';

class WordListBloc extends Bloc<WordListEvents, WordListStates> {
  late int totalCharacterCount = 0;
  var collectedWords = <String>{};

  WordListBloc() : super(InitialState()) {
    on<AddTextToListEvent>(onAddText);
  }

  void onAddText(AddTextToListEvent event, Emitter<WordListStates> emit) async {
    if (event.text.isEmpty) {
      return;
    }

    collectedWords.add(event.text);
    totalCharacterCount += event.text.length;

    emit(UpdateState(collectedWords, totalCharacterCount));
  }
}

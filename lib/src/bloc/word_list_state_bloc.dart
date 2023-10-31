part of 'word_list_bloc.dart';

class WordListStates {
  get totalCharacterCount => 0;
}

class InitialState extends WordListStates {}

class UpdateState extends WordListStates {
  var collectedWords = <String>{};
  @override
  int totalCharacterCount = 0;

  UpdateState(this.collectedWords, this.totalCharacterCount);
}

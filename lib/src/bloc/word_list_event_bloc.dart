part of 'word_list_bloc.dart';

class WordListEvents {}

class AddTextToListEvent extends WordListEvents {
  final String text;

  AddTextToListEvent({required this.text});
}

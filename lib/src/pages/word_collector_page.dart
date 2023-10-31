import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_score_keeper_app/src/bloc/word_list_bloc.dart';
import '../components/buttons.dart';
import '../components/text_inputfield.dart';
import '../formatters/formatters.dart';
import 'word_score_page.dart';

class WordCollectorPage extends StatefulWidget {
  const WordCollectorPage({super.key});

  @override
  State<WordCollectorPage> createState() => _WordCollectorPageState();
}

class _WordCollectorPageState extends State<WordCollectorPage> {
  TextEditingController textController = TextEditingController();
  List<String> collectedWords = [];
  bool isAddButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    textController.addListener(_updateAddButtonState);
  }

  @override
  void dispose() {
    textController.removeListener(_updateAddButtonState);
    textController.dispose();
    super.dispose();
  }

  void _updateAddButtonState() {
    setState(() {
      isAddButtonEnabled = textController.text.isNotEmpty;
    });
  }

  void _viewCollectedWords() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return const CollectedWordsPage();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: const Center(
          child: Text(
            'Word Score Keeper',
            style: TextStyle(color: Colors.black),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.score),
            color: Colors.black,
            onPressed: _viewCollectedWords,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
            child: TextInputField(
              controller: textController,
              hintText: 'Type here to add Words',
              formatter: getWordFormatter(),
            ),
          ),
          MainButton(
            onTap: () {
              context
                  .read<WordListBloc>()
                  .add(AddTextToListEvent(text: textController.text));

              textController.clear();
            },
            text: 'Add to List',
            enabled: isAddButtonEnabled,
          ),
          Expanded(
            child: BlocBuilder<WordListBloc, WordListStates>(
              builder: (context, state) {
                if (state is InitialState) {
                  return _texter(context, {""});
                }
                if (state is UpdateState) {
                  return _texter(context, state.collectedWords);
                }
                return Container();
              },
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}

Widget _texter(BuildContext context, dynamic collectedWords) {
  String collectedWordsText = collectedWords.join(' ');

  TextStyle textStyle = const TextStyle(
    color: Colors.black,
    fontSize: 22,
  );
  TextStyle lastWordStyle = const TextStyle(
    color: Colors.red,
    fontSize: 22,
  );

  String lastWord = collectedWords.isEmpty ? '' : collectedWords.last;

  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: collectedWordsText.substring(
                      0, collectedWordsText.length - lastWord.length),
                  style: textStyle,
                ),
                TextSpan(
                  text: lastWord,
                  style: lastWordStyle,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_score_keeper_app/src/bloc/word_list_bloc.dart';
import 'package:word_score_keeper_app/src/components/todo_tile.dart';

class CollectedWordsPage extends StatelessWidget {
  const CollectedWordsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<String> collectedWordList;
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Score View',
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.grey[300],
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Accumulated Score:',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<WordListBloc, WordListStates>(
                  builder: (context, state) {
                    return Text(
                      state.totalCharacterCount.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Expanded(
            child: BlocBuilder<WordListBloc, WordListStates>(
              builder: (context, state) {
                if (state is InitialState) {
                  return const Center(
                    child: Text(
                      'There is no element added to the List',
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                }
                if (state is UpdateState) {
                  return ListView.builder(
                    itemCount: state.collectedWords.length,
                    itemBuilder: (BuildContext context, int index) {
                      collectedWordList = state.collectedWords.toList();
                      return CollectedListTile(
                        listText: collectedWordList[index],
                      );
                    },
                  );
                }

                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}

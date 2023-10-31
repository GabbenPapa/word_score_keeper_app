import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_score_keeper_app/src/bloc/word_list_bloc.dart';
import 'src/pages/word_collector_page.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => WordListBloc(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Word Score Keeper Application',
      debugShowCheckedModeBanner: false,
      home: WordCollectorPage(),
    );
  }
}

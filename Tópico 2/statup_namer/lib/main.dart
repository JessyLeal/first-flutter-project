import 'dart:ui';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

enum ViewType { grid, list }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random(); // Add this line.
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18);
  ViewType _viewType = ViewType.list;
  int _colum = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statup Name Genaretor'),
      ),
      floatingActionButton: FloatingActionButton(
          child:
              Icon(_viewType == ViewType.grid ? Icons.grid_view : Icons.list),
          onPressed: () {
            if (_viewType == ViewType.grid) {
              _viewType = ViewType.list;
              _colum = 1;
            } else {
              _viewType = ViewType.grid;
              _colum = 2;
            }
            setState(() {});
          }),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _colum,
        childAspectRatio: _viewType == ViewType.grid ? 1 : 10,
      ),
      itemBuilder: (context, i) {
        if (i.isOdd && _viewType == ViewType.list) {
          return const Divider();
        }

        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    if (_viewType == ViewType.grid) {
      return Card(
        margin: const EdgeInsets.all(12),
        child: Center(
            child: Text(
          pair.asPascalCase,
          style: _biggerFont,
        )),
      );
    } else {
      return ListTile(
        title: Text(
          pair.asPascalCase,
          // style: _biggerFont,
        ),
      );
    }
  }
}

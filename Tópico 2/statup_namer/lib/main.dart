import 'dart:ui';
import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ViewType { grid, list }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 54, 244, 63),
          foregroundColor: Color.fromARGB(255, 0, 0, 0),
        ),
      ),
      home: const RandomWords(),
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
  final _saved = <WordPair>{};
  final _biggerFont = const TextStyle(fontSize: 18);

  ViewType _viewType = ViewType.list;
  int _colum = 1;

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          final tiles = _saved.map(
            (pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(
                  context: context,
                  tiles: tiles,
                ).toList()
              : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              title: const Text('Favoritados'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Name Generator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: _pushSaved,
            tooltip: 'Favoritados',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 54, 244, 219),
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
      padding: const EdgeInsets.all(4.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _colum,
        childAspectRatio: _viewType == ViewType.grid ? 1 : 10,
      ),
      itemBuilder: (context, i) {
        if (i.isOdd && _viewType == ViewType.list) {
          return const Divider();
        }

        final index = i ~/ 1;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }

        final alreadySaved =
            _saved.contains(_suggestions[index]); 
        return ListTile(
            title: Text(
              _suggestions[index].asPascalCase,
              style: _biggerFont,
            ),
            trailing: Wrap(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    alreadySaved ? Icons.favorite : Icons.favorite_border,
                    color: alreadySaved
                        ? Color.fromARGB(255, 66, 54, 241)
                        : null,
                    semanticLabel: alreadySaved
                        ? 'Desfavoritar'
                        : 'Salvo',
                  ),
                  onPressed: () {
                    setState(() {
                      if (alreadySaved) {
                        _saved.remove(_suggestions[index]);
                      } else {
                        _saved.add(_suggestions[index]);
                      }
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(
                    CupertinoIcons.delete,
                    semanticLabel: 'Deletado',
                  ),
                  onPressed: () {
                    setState(() {
                      if (alreadySaved) {
                        _saved.remove(_suggestions[index]);
                      }
                      _suggestions
                          .remove(_suggestions[index]); //remove do array
                    });
                  },
                ),
              ],
            ));
      },
    );
  }
}

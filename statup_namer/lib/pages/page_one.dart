import 'dart:ui';
import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:statup_namer/pages/edit_page.dart';

enum ViewType { grid, list }

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class Words {
  List<String> _words = [];

  List<String> getAllWords() {
    _words = [
      'DiamontMount','BlueSharp','FishTarget','ParckMont','MonkeyGrid','WidgetTrue','BabyGirl','BlankSpace','DocksTrigger','BabyShark','FlutterBank','RichRead','TriggerSpace','ScriptSeason','JackNivea','RubyUpper','BrandFive','WithKnes','VuePax','MouthEight' ];
    return _words;
  }
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <String>[];
  final _saved = <String>{};
  final _biggerFont = const TextStyle(fontSize: 18);
  int _crossAxisCount = 2;
  ViewType _viewType = ViewType.grid;
  List<String> _word = Words().getAllWords();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Name Generator'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(_viewType == ViewType.list ? Icons.list : Icons.grid_view),
        onPressed: () {
          if (_viewType == ViewType.list) {
            _crossAxisCount = 2;
            _viewType = ViewType.grid;
          } else {
            _crossAxisCount = 1;
            _viewType = ViewType.list;
          }
          setState(() {});
        },
      ),
      body: Container(
        child: _build(),
      ),
    );
  }

  Widget _build() {

    return GridView.builder(
        itemCount: _word.length,
        padding: const EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _crossAxisCount,
          childAspectRatio: _viewType == ViewType.grid ? 1 : 10,
        ),
        itemBuilder: (BuildContext _context, int i) {
          final int index = i;
          index == 20 ? index - 1 : index;
          final alreadySaved = _saved.contains(_word[index]);

          return _buildRowCollumns(_word[index], alreadySaved, index);
        });
  }

  Widget _buildRowCollumns(pair, alreadySaved, index) {
    if (_viewType == ViewType.grid) {
      return Card(
        margin: const EdgeInsets.all(16),
        child: Column(children: [
          Text(
            pair,
            style: _biggerFont,
          ),
          IconButton(
            icon: Icon(
              alreadySaved ? Icons.favorite : Icons.favorite_border,
              color: alreadySaved ? Color.fromARGB(255, 18, 211, 66) : null,
              semanticLabel: alreadySaved ? 'Removido' : 'Salvo',
            ),
            onPressed: () {
              setState(() {
                if (alreadySaved) {
                  _saved.remove(pair);
                } else {
                  _saved.add(pair);
                }
              });
            },
          ),
        ]),
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: InkWell(
              child: Text(
                pair,
                style: _biggerFont,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TextEdt(
                        words: _word, index: index, isEdit: true,
                      ),
                    )).then((_) => setState(() {}));
              },
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.delete,
                ),
                onPressed: () {
                  setState(() {
                    _word.removeWhere((item) => item == pair);
                  });
                },
              ),
              IconButton(
                icon: Icon(
                  alreadySaved ? Icons.favorite : Icons.favorite_border,
                  color: alreadySaved ? Color.fromARGB(255, 74, 23, 83) : null,
                  semanticLabel: alreadySaved ? 'Removido' : 'Salvo',
                ),
                onPressed: () {
                  setState(() {
                    if (alreadySaved) {
                      _saved.remove(pair);
                    } else {
                      _saved.add(pair);
                    }
                  });
                },
              ),
            ],
          )
        ],
      );
    }
  }
}

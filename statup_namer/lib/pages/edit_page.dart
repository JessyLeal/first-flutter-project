import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class TextEdt extends StatefulWidget {
  TextEdt({required this.words, required this.index});
  List<String> words;
  int index;
  @override
  _TextEdt createState() => _TextEdt();
}

class _TextEdt extends State<TextEdt> {
  List<String> words = [];
  String initialWord = '';
  int index = 0;
  final controller = TextEditingController(text: '');

  void initState() {
    super.initState();
    words = widget.words;
    index = widget.index;
    initialWord = words[widget.index];
    controller.text = initialWord;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Genarator Names'),
      ),
      body: Container(
        child: _build(),
      ),
    );
  }

  Widget _build() {
    return Column(
      children: [
        Padding(
          padding: new EdgeInsets.all(10.0),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              child: const Text('BACK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(width: 15),
            ElevatedButton(
              onPressed: () {
                words[index] = controller.text;
              },
              child: const Text('SAVE'),
            ),
          ],
        )
      ],
    );
  }
}

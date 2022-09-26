import 'package:english_words/english_words.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TextEdt extends StatefulWidget {
  List<String> words;
  int index;
  bool isEdit;

  TextEdt({required this.words, required this.index, required this.isEdit});

  @override
  _TextEdt createState() => _TextEdt();
}

  Future createLanguage({required String name}) async {
    final docLanguage =
        FirebaseFirestore.instance.collection('languages').doc();
    final language = {'name': name, 'id': docLanguage.id};
    await docLanguage.set(language);
  }

class _TextEdt extends State<TextEdt> {
  List<String> words = [];
  String initialWord = '';
  int index = 0;
  bool isEdit = false;
  final controller = TextEditingController(text: '');

  void initState() {
    super.initState();
    words = widget.words;
    index = widget.index;
    isEdit = widget.isEdit;
    initialWord = widget.isEdit ? words[widget.index] : '';
    controller.text = initialWord;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerador de Nomes'),
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
              child: const Text('Voltar'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(width: 15),
            ElevatedButton(
              onPressed: () {
                if (isEdit) {
                  words[index] = controller.text;
                } else {
                  words.add(controller.text);
                  Navigator.pop(context);
                }
              },
              child: Text(isEdit ? 'SAVE' : 'CREATE'),
            ),
          ],
        )
      ],
    );
  }
}


import 'dart:ui';
import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:statup_namer/pages/page_one.dart';
import 'package:statup_namer/pages/edit_page.dart';

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
          backgroundColor: Color.fromARGB(255, 55, 104, 238),
          foregroundColor: Color.fromARGB(255, 0, 0, 0),
        ),
      ),
      routes: {
        '/': (context) => const RandomWords()
        }
    );
  }
}
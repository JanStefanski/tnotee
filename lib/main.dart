// main.dart
import 'package:flutter/material.dart';
import 'package:tnotee/pages/note_list_page.dart';
import 'package:tnotee/helpers/router.dart';
void main() {
  runApp(const NoteApp());
}


class NoteApp extends StatelessWidget {
  const NoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'tnotee',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NoteListPage(),
      onGenerateRoute: generateRoute,
    );
  }
}

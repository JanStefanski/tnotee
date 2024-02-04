// pages/note_list_page.dart
import 'package:flutter/material.dart';
import 'package:tnotee/models/note.dart';
import 'package:tnotee/helpers/db_helper.dart';

class NoteListPage extends StatefulWidget {
  const NoteListPage({super.key});

  @override
  _NoteListPageState createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future _loadNotes() async {
    final notes = await DatabaseHelper.instance.getAllNotes();
    setState(() {
      this.notes = notes;
    });
  }


  Future<void> _addNewNote(BuildContext context) async {
    final Object? newNote = await Navigator.of(context).pushNamed('/addNote');


    if (newNote != null) {
      setState(() {
        _loadNotes();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TnoTee')
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(notes[index].title),
            subtitle: Text(notes[index].content.split('\n').first),
            onTap: () async {
              String noteId = notes[index].id;
              await Navigator.of(context).pushNamed('/previewNote', arguments: noteId);
              setState(() {
                _loadNotes();
              });
            },
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                await DatabaseHelper.instance.deleteNote(notes[index].id);
                setState(() {
                  notes.removeAt(index);
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewNote(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

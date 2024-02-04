// pages/note_add_page.dart
import 'package:flutter/material.dart';
import 'package:tnotee/models/note.dart';
import 'package:tnotee/helpers/db_helper.dart';

class NoteAddPage extends StatefulWidget {
  final Note? note; // Optional note for editing

  const NoteAddPage({super.key, this.note});

  @override
  _NoteAddPageState createState() => _NoteAddPageState();
}
class _NoteAddPageState extends State<NoteAddPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(widget.note?.id ?? 'New note'),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            Expanded(
              child: TextField(
                controller: _contentController,
                maxLines: null, // Allows the text field to expand vertically
                keyboardType: TextInputType.multiline, // Enables line breaks
                expands: true, // Ensures the TextField expands to fill the space
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final Note resultNote = Note(
                  id: widget.note?.id, // Use the existing note's ID if editing
                  title: _titleController.text,
                  content: _contentController.text,
                );
                if (widget.note == null) {
                  await DatabaseHelper.instance.addNote(resultNote);
                } else {
                  await DatabaseHelper.instance.updateNote(resultNote);
                }
                final action = widget.note == null ? 'add' : 'edit';
                Navigator.pop(context, resultNote);
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}

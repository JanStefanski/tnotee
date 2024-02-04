// pages/note_add_page.dart
import 'package:flutter/material.dart';
import 'package:tnotee/models/note.dart';
import 'package:tnotee/helpers/db_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NoteAddPage extends StatefulWidget {
  final Note? note;

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
        title: Text(widget.note?.id != null ? AppLocalizations.of(context)!.editNote : AppLocalizations.of(context)!.addNote),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: AppLocalizations.of(context)!.title),
            ),
            Expanded(
              child: TextField(
                controller: _contentController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                expands: true,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final Note resultNote = Note(
                  id: widget.note?.id,
                  title: _titleController.text,
                  content: _contentController.text,
                );
                if (widget.note == null) {
                  await DatabaseHelper.instance.addNote(resultNote);
                } else {
                  await DatabaseHelper.instance.updateNote(resultNote);
                }
                Navigator.pop(context, resultNote);
              },
              child: Text(AppLocalizations.of(context)!.save),
            ),
          ],
        ),
      ),
    );
  }
}

// pages/note_preview_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:tnotee/models/note.dart';
import 'package:tnotee/helpers/db_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotePreviewPage extends StatefulWidget {
  final String noteId;

  NotePreviewPage({Key? key, required this.noteId}) : super(key: key);

  @override
  _NotePreviewPageState createState() => _NotePreviewPageState();
}

class _NotePreviewPageState extends State<NotePreviewPage> {
  Note? note;

  @override
  void initState() {
    super.initState();
    loadNote();
  }

  void loadNote() async {
    note = await DatabaseHelper.instance.getNote(widget.noteId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(note?.title ?? AppLocalizations.of(context)!.loading),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              await Navigator.of(context).pushNamed('/addNote', arguments: note);
              loadNote();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: note != null ? Markdown(data: note!.content) : Center(child: Text(AppLocalizations.of(context)!.loading)),
      ),
    );
  }
}
// helpers/router.dart
import 'package:flutter/material.dart';
import 'package:tnotee/models/note.dart';
import 'package:tnotee/pages/note_list_page.dart';
import 'package:tnotee/pages/note_add_page.dart';
import 'package:tnotee/pages/note_preview_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => const NoteListPage());
    case '/addNote':
      final note = settings.arguments as Note?;
      return _createRoute(NoteAddPage(note: note));
    case '/previewNote':
      final noteId = settings.arguments as String;
      return _createRoute(NotePreviewPage(noteId: noteId));
    default:
      return MaterialPageRoute(builder: (context) => const NoteListPage());
  }
}

Route<dynamic> _createRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

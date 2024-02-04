// models/note.dart
import 'package:uuid/uuid.dart';

class Note {
  String id;
  String title;
  String content;

  Note({
    String? id,
    required this.title,
    required this.content,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
    };
  }

  static Note fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
    );
  }
}
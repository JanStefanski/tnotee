// models/note.dart
import 'package:uuid/uuid.dart';

class Note {
  String id;
  String title;
  String content;

  Note({
    String? id, // Allow specifying an ID, but it's optional
    required this.title,
    required this.content,
  }) : id = id ?? const Uuid().v4(); // Generate a new UUID if no ID is provided

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
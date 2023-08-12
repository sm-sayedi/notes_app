import 'dart:convert';

class Note {
  String title;
  String content;
  int color;
  int updatedAt;
  final int createdAt;

  Note({
    required this.title,
    required this.content,
    required this.color,
    required this.updatedAt,
    required this.createdAt,
  });

  @override
  String toString() {
    return 'Note(title: $title,\ncontent: $content,\ncolor: $color,\nupdatedAt: $updatedAt,\ncreatedAt: $createdAt)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'content': content,
      'color': color,
      'updatedAt': updatedAt,
      'createdAt': createdAt,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      title: map['title'] as String,
      content: map['content'] as String,
      color: map['color'] as int,
      updatedAt: map['updatedAt'] as int,
      createdAt: map['createdAt'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) =>
      Note.fromMap(json.decode(source) as Map<String, dynamic>);
}

import 'dart:convert';

class Note {
  String title;
  String content;
  int color;
  final int createdAt;
  int updatedAt;

  Note({
    required this.title,
    required this.content,
    required this.color,
    required this.createdAt,
    required this.updatedAt,
  });

  static const String titleLabel = 'title';
  static const String contentLabel = 'content';
  static const String colorLabel = 'color';
  static const String createdAtLabel = 'createdAt';
  static const String updatedAtLabel = 'updatedAt';

  @override
  String toString() {
    return 'Note(title: $title,\ncontent: $content,\ncolor: $color,\nupdatedAt: $updatedAt,\ncreatedAt: $createdAt)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      titleLabel: title,
      contentLabel: content,
      colorLabel: color,
      createdAtLabel: createdAt,
      updatedAtLabel: updatedAt,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      title: map[titleLabel] as String,
      content: map[contentLabel] as String,
      color: map[colorLabel] as int,
      createdAt: map[createdAtLabel] as int,
      updatedAt: map[updatedAtLabel] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) =>
      Note.fromMap(json.decode(source) as Map<String, dynamic>);
}

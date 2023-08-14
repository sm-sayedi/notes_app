import 'package:sqflite/sqflite.dart';

import '../models/models.dart';
import 'services.dart';

class NoteDBHelper {
  NoteDBHelper._();

  static const String tableName = 'notes';
  static const String title = Note.titleLabel;
  static const String content = Note.contentLabel;
  static const String color = Note.colorLabel;
  static const String createdAt = Note.createdAtLabel;
  static const String updatedAt = Note.updatedAtLabel;

  static Future<void> createTable(Database database) async {
    database.execute(
      '''CREATE TABLE $tableName (
          $title TEXT, 
          $content TEXT, 
          $color INT, 
          $createdAt INT, 
          $updatedAt INT)''',
    );
  }

  static Future<List<Note>> query() async {
    final Database database = await DatabaseService().database;
    final List<Map<String, Object?>> data =
        await database.query(tableName, orderBy: '$updatedAt DESC');
    return data.map((e) => Note.fromMap(e)).toList();
  }

  static Future<int> insert(Note note) async {
    final Database database = await DatabaseService().database;
    return await database.insert(tableName, note.toMap());
  }

  static Future<int> update(Note note) async {
    final Database database = await DatabaseService().database;
    return await database.update(
      tableName,
      {
        title: note.title,
        content: note.content,
        color: note.color,
        updatedAt: note.updatedAt,
      },
      where: '$createdAt = ?',
      whereArgs: [note.createdAt],
    );
  }

  static Future<int> delete(Note note) async {
    final Database database = await DatabaseService().database;
    return await database.delete(
      tableName,
      where: '$createdAt = ?',
      whereArgs: [note.createdAt],
    );
  }
}

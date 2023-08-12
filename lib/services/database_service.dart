import 'package:notes_app/services/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _database;

  Future<Database> get database async {
    return _database ??= await initialize();
  }

  Future<Database> initialize() async {
    final path = await fullPath;

    // Open or Create the database at the given path
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: _create,
      singleInstance: true,
    );
    return database;
  }

  Future<String> get fullPath async {
    const name = 'app_database';
    final path = await getDatabasesPath();
    return join(path, name);
  }

  void _create(Database db, int newVersion) async {
    await NoteDBHelper.createTable(db);
  }
}

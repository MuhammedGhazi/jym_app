import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class SqlServices {
  static Database? _db;
  Future<Database> get db async {
    _db ??= await intiaDB();
    return _db!;
  }

  intiaDB() async {
    var databasePath = await getDatabasesPath();
    String path = p.join(databasePath, "gym.db");
    print(path);
    Database db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE subs(id INTEGER PRIMARY KEY AUTOINCREMENT,
          fullName TEXT,
          tall INTEGER,
          weight INTEGER,
          category TEXT,
          note TEXT,
          dateRecord TEXT,
          upToRecord TExT)
          ''');
        print(
            "create date base and table successful====================================");
      },
    );
    return db;
  }

  deletDB() async {
    var databasePath = await getDatabasesPath();
    String path = p.join(databasePath, "gym.db");
    await deleteDatabase(path);
  }
}

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _databaseName = "my_database.db";
  static final _databaseVersion = 1;

  static final table = 'images';

  static final columnId = '_id';
  static final columnName = 'name';
  static final columnImage = 'image';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $columnName TEXT NOT NULL,
        $columnImage BLOB
      )
    ''');
  }

  Future<int> insertImage(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllImages() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  // 指定された名前で画像を検索する関数
  Future<List<Map<String, dynamic>>> queryImageByName(String name) async {
    Database db = await instance.database;
    return await db.query(table, where: '$columnName = ?', whereArgs: [name]);
  }
}

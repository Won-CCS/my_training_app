import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDatabase();
    return _db!;
  }

  DatabaseHelper.internal();

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'my_training.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE data_table (
        id INTEGER PRIMARY KEY,
        imagePath TEXT,
        textContent TEXT
      )
    ''');
  }

  Future<int> insertData(String imagePath, String textContent) async {
    Database database = await db;
    Map<String, dynamic> row = {
      'imagePath': imagePath,
      'textContent': textContent,
    };
    return await database.insert('data_table', row);
  }

  Future<List<Map<String, dynamic>>> getAllData() async {
    Database database = await db;
    return await database.query('data_table');
  }
}

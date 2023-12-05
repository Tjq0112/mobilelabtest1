import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteDB{
  static const String _dbName = "bitp3453_bmi";

  Database? _db;

  SQLiteDB._();
  static final SQLiteDB _instance = SQLiteDB._();

  factory SQLiteDB(){
    return _instance;
  }

  Future<Database> get database async {
    if(_db != null){
      return _db!;
    }
    String path = join(await getDatabasesPath(), _dbName,);
    _db = await openDatabase(path, version: 1, onCreate: (createdDb,version) async {
      for(String tableSql in SQLiteDB.tableSQLStrings){
        await createdDb.execute(tableSql);
      }
    },);
    return _db!;
  }

  static List<String> tableSQLStrings =
      [
        '''
          CREATE TABLE IF NOT EXISTS bmi
          (_colUsername TEXT,
          _colHeight DOUBLE,
          _colWeight DOUBLE,
          _colGender TEXT,
          _colStatus TEXT,
        '''
      ];

  Future<int> insert(String tableName, Map<String, dynamic> row) async {
    Database db = await _instance.database;
    return await db.insert(tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAll(String tableName) async {
    Database db = await _instance.database;
    return await db.query(tableName);
  }

  Future<int> update(String tableName, String _colUsername, Map<String, dynamic> row) async {
    Database db = await _instance.database;
    dynamic username = row[_colUsername];
    return await db.update(tableName, row, where: "$_colUsername =?", whereArgs: [username]);
  }

  Future<int> delete(String tableName, String _colUsername, dynamic username) async {
    Database db = await _instance.database;
    return await db.delete(tableName, where: '$_colUsername = ?', whereArgs: [username]);
  }
}
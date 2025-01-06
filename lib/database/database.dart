import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DataClass {
  Database? _db;
  static final DataClass _instance = DataClass._internal();
  //factory method
  factory DataClass() => _instance;
  DataClass._internal();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initdb();
    return _database;
  }

  Future<Database> initdb() async {
    Directory databasePath = await getApplicationDocumentsDirectory();
    String path = join(databasePath.path, "expensetracker.db");
    var db = await openDatabase(path, version: 1, onCreate: oncreate);
    return db;
  }

  Future<void> deleteDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "expensetracker.db");
    await databaseFactory.deleteDatabase(path);
  }

  void oncreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE expensemodel(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, type TEXT, amount DOUBLE, date TEXT)");
  }

  Future<Database> get db async {
    if (_db == null) {
      _db = await initdb();
    }
    return _db!;
  }

  Future<int> create(Crudmodel crud) async {
    var dbready = await db;
    return await dbready.insert(
      'expensemodel',
      crud.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> update(Crudmodel crud) async {
    var dbready = await db;
    return await dbready.update(
      'expensemodel',
      crud.toMap(),
      where: 'id = ?',
      whereArgs: [crud.id],
    );
  }

  Future<int> delete(int id) async {
    var dbready = await db;
    return await dbready.delete(
      'expensemodel',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Crudmodel?> read(int id) async {
    var dbready = await db;
    List<Map<String, dynamic>> maps = await dbready.query(
      'expensemodel',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Crudmodel.fromMap(maps.first);
    } else {
      return null; // Handle case when no data is found
    }
  }

  Future<ReadAllResult> readAllwithtotal() async {
    var dbready = await db;
    List<Map<String, dynamic>> maps = await dbready.query('expensemodel');
    List<Crudmodel> data = maps.map((map) => Crudmodel.fromMap(map)).toList();
    double total = data.fold(0, (sum, item) => sum + (item.amount ?? 0));
    return ReadAllResult(data, total);
  }

  readAll() async {
    var dbready = await db;
    List<Map<String, dynamic>> maps = await dbready.query('expensemodel');
    List<Crudmodel> data = maps.map((map) => Crudmodel.fromMap(map)).toList();
    return data;
  }

  totalamount() async {
    var earn = await getTotalEarnings();
    var exp = await getTotalExpenses();
    var sum = earn - exp;
    return sum;
  }

  Future<double> getTotalEarnings() async {
    var dbready = await db;
    List<Map> maps = await dbready
        .query('expensemodel', where: 'type = ?', whereArgs: ['Earn']);
    double total = maps.fold(0, (sum, item) => sum + (item['amount'] ?? 0));
    return total;
  }

  Future<double> getTotalExpenses() async {
    var dbready = await db;
    List<Map> maps = await dbready
        .query('expensemodel', where: 'type = ?', whereArgs: ['Expense']);
    double total = maps.fold(0, (sum, item) => sum + (item['amount'] ?? 0));
    return total;
  }
}

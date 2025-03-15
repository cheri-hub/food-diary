import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/food_entry.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, 'meals.db');

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE meals (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            date TEXT NOT NULL
          )
          ''',
        );
      },
    );
  }

  // Inserir refeição
  Future<int> insertMeal(FoodEntry meal) async {
    final db = await database;
    return await db.insert('meals', meal.toMap());
  }

  // Buscar todas as refeições
  Future<List<FoodEntry>> getAllMeals() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('meals');

    return List.generate(maps.length, (i) {
      return FoodEntry.fromMap(maps[i]);
    });
  }

  // Deletar uma refeição
  Future<int> deleteMeal(int id) async {
    final db = await database;
    return await db.delete('meals', where: 'id = ?', whereArgs: [id]);
  }
}

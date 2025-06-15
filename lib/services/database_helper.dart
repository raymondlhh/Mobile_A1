import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../models/favourite_food.dart';

class DatabaseHelper {
  static const _databaseName = "favorites.db";
  static const _databaseVersion = 1;
  static const table = 'favorites';

  static Database? _database;

  // Singleton pattern
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        rating REAL NOT NULL,
        totalRating TEXT NOT NULL,
        imagePath TEXT NOT NULL
      )
    ''');
  }

  Future<int> insert(FavouriteFood food) async {
    final db = await database;
    return await db.insert(
      table,
      {
        'name': food.name,
        'rating': food.rating,
        'totalRating': food.totalRating,
        'imagePath': food.imagePath,
      },
    );
  }

  Future<List<FavouriteFood>> getAllFavorites() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(table);
    
    return List.generate(maps.length, (i) {
      return FavouriteFood(
        name: maps[i]['name'],
        rating: maps[i]['rating'],
        totalRating: maps[i]['totalRating'],
        imagePath: maps[i]['imagePath'],
      );
    });
  }

  Future<int> delete(String name) async {
    final db = await database;
    return await db.delete(
      table,
      where: 'name = ?',
      whereArgs: [name],
    );
  }

  Future<bool> isFavorite(String name) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      table,
      where: 'name = ?',
      whereArgs: [name],
    );
    return result.isNotEmpty;
  }
} 
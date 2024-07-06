import 'package:sqflite/sqflite.dart';
import 'package:tastead/models/favorite_restaurant.dart';

class FavoriteDatabaseHelper {
  static Database? _database;
  static final FavoriteDatabaseHelper instance =
      FavoriteDatabaseHelper._privateConstructor();

  FavoriteDatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return openDatabase(
      'favorite_restaurants.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE favorites(
            id TEXT PRIMARY KEY,
            name TEXT,
            description TEXT,
            pictureId TEXT,
            city TEXT,
            rating REAL
          )
        ''');
      },
    );
  }

  Future<void> insertFavorite(FavoriteRestaurant restaurant) async {
    final db = await database;
    await db.insert('favorites', restaurant.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> removeFavorite(String id) async {
    final db = await database;
    await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<FavoriteRestaurant>> getFavorites() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('favorites');
    return List.generate(maps.length, (i) {
      return FavoriteRestaurant(
        id: maps[i]['id'],
        name: maps[i]['name'],
        description: maps[i]['description'],
        pictureId: maps[i]['pictureId'],
        city: maps[i]['city'],
        rating: maps[i]['rating'],
      );
    });
  }
}

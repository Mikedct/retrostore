import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../models/game_model.dart';

class DbHelper {
  static final DbHelper dbHelper = DbHelper._();
  late Database database;

  final String tableName = 'games';

  DbHelper._();

  Future<void> initDatabase() async {
    database = await connectToDatabase();
  }

  Future<Database> connectToDatabase() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, 'games.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableName (
            gameID INTEGER PRIMARY KEY AUTOINCREMENT,
            gameCode TEXT NOT NULL UNIQUE,
            title TEXT NOT NULL,
            genre TEXT NOT NULL,
            platform TEXT NOT NULL,
            price INTEGER NOT NULL,
            releaseDate TEXT NOT NULL,
            developer TEXT NOT NULL,
            publisher TEXT NOT NULL,
            description TEXT NOT NULL,
            image TEXT NOT NULL,
            videoLink TEXT NOT NULL,
            adminID INTEGER NOT NULL,
            isFavorite INTEGER NOT NULL
          )
        ''');

        // Tambahkan data awal
        await db.insert('$tableName', {
          'gameCode': 'AC001',
          'title': 'Contra',
          'genre': 'Action',
          'platform': 'Nintendo Entertainment System (NES)',
          'price': 0,
          'releaseDate': '1987-02-20',
          'developer': 'Konami',
          'publisher': 'Konami',
          'description': 'Contra is a run-and-gun action platformer video game notorious for its high difficulty.',
          'image': 'contra.png',
          'videoLink': 'https://www.youtube.com/embed/OotQrKEqe94',
          'adminID': 1,
          'isFavorite': 0,
        });

        await db.insert('$tableName', {
          'gameCode': 'PZ003',
          'title': 'Tetris',
          'genre': 'Puzzle',
          'platform': 'Nintendo Entertainment System (NES)',
          'price': 0,
          'releaseDate': '1984-06-06',
          'developer': 'Nintendo',
          'publisher': 'Nintendo',
          'description': 'Tetris is a tile-matching video game created by Russian software engineer Alexey Pajitnov in 1984.',
          'image': 'tetris.png',
          'videoLink': 'https://www.youtube.com/embed/c80dVYcL69E',
          'adminID': 2,
          'isFavorite': 0,
        });
      }
    );
  }

  // Ambil semua game
  Future<List<GameModel>> getAllGames() async {
    final List<Map<String, dynamic>> result = await database.query(tableName);
    return result.map((e) => GameModel.fromMap(e)).toList();
  }

  // Tambah game baru
  Future<void> insertNewGame(GameModel game) async {
    await database.insert(tableName, game.toMap());
  }

  // Update game
  Future<void> updateGame(GameModel game) async {
    await database.update(
      tableName,
      game.toMap(),
      where: 'gameID = ?',
      whereArgs: [game.gameID],
    );
  }

  // Hapus game
  Future<void> deleteGame(int gameID) async {
    await database.delete(
      tableName,
      where: 'gameID = ?',
      whereArgs: [gameID],
    );
  }

  // Ubah favorit
  Future<void> updateIsFavorite(GameModel game) async {
    await database.update(
      tableName,
      {'isFavorite': game.isFavorite ? 1 : 0},
      where: 'gameID = ?',
      whereArgs: [game.gameID],
    );
  }
}

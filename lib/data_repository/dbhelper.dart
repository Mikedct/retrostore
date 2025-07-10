import 'dart:io';
import 'package:retrostore/models/game_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

//Testing push

class DbHelper {
  late Database database;
  static DbHelper dbHelper = DbHelper();
  final String tableName = 'games';
  final String namaColumn = 'nama';
  final String idColumn = 'id';
  final String isFavoriteColumn = 'isFavorite';
  final String bahanColumn = 'bahan';
  final String langkahColumn = 'langkah';
  final String durasiMasakColumn = 'durasiMasak';
  final String imageColumn = 'image';

  initDatabase() async{
    database = await connectToDatabase();
  }

Future<Database> connectToDatabase() async{
  Directory directory = await getApplicationDocumentsDirectory();
  String path = '$directory/games.db';
  return openDatabase(path,
    version: 1,
    onCreate: (db, version) {
      db.execute(
        'CREATE TABLE $tableName ($idColumn INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$namaColumn TEXT, $durasiMasakColumn INTEGER,'
        '$isFavoriteColumn INTEGER, $bahanColumn TEXT,'
        '$langkahColumn TEXT, $imageColumn TEXT)');
      },
      onUpgrade: (db, oldVersion, newVersion){
        db.execute(
          'CREATE TABLE $tableName ($idColumn INTEGER PRIMARY KEY AUTOINCREMENT,'
          '$namaColumn TEXT, $durasiMasakColumn INTEGER,'
          '$isFavoriteColumn INTEGER, $bahanColumn TEXT, '
          '$langkahColumn TEXT, $imageColumn TEXT)');
        },
      onDowngrade: (db, oldVersion, newVersion) {
      db.delete(tableName);
      },
    );
  }
  Future<List<GameModel>> getAllGames() async{
    List<Map<String, dynamic>> tasks = await database.query (tableName);
    return tasks.map((e) => GameModel.fromMap(e)).toList();
  }
  
  insertNewGame (GameModel gameModel) {
    database.insert(tableName, gameModel.toMap());
  }

  deleteGame (GameModel gameModel) {
    database.delete (tableName, where: '$idColumn=?', whereArgs: [gameModel.id]);
  }

  deleteGames(){
    database.delete (tableName);
  }

  updateGame(GameModel gameModel) async{
    await database.update(
      tableName,
    {
      isFavoriteColumn: gameModel.isFavorite ? 1:0,
      namaColumn: gameModel.nama,
      durasiMasakColumn: gameModel.durasiMasak,
      imageColumn: gameModel.image!.path,
      bahanColumn: gameModel.bahan,
      langkahColumn: gameModel.langkah
      },
      where: '$idColumn=?',
      whereArgs: [gameModel.id]);
  }
  
  updateIsFavorite (GameModel gameModel) {
    database.update(
    tableName, {isFavoriteColumn: ! gameModel.isFavorite ? 1:0},
    where: '$idColumn=?', whereArgs: [gameModel.id]);
  }
}
import 'dart:io';
import 'package:flutter/material.dart';
import '../data_repository/dbhelper.dart';
import '../models/game_model.dart';

class GameClass extends ChangeNotifier {
  GameClass() {
    getGames();
  }

  bool isDark = false;
  changeIsDark() {
    isDark = !isDark;
    notifyListeners();
  }

  TextEditingController namaController = TextEditingController();
  TextEditingController durasiMasakController = TextEditingController();
  TextEditingController langkahController = TextEditingController();
  TextEditingController bahanController = TextEditingController();
  File? image;

  List<GameModel> allGames = [];
  List<GameModel> favoriteGames = [];

  getGames() async {
    allGames = await DbHelper.dbHelper.getAllGames();
    favoriteGames = allGames.where((e) => e.isFavorite).toList();
    notifyListeners();
  }

  insertNewGame() {
    GameModel gameModel = GameModel(
      nama: namaController.text,
      isFavorite: false,
      image: image,
      bahan: bahanController.text,
      langkah: langkahController.text,
      durasiMasak: int.parse(durasiMasakController.text != ''
          ? durasiMasakController.text
          : '0'),
    );
    DbHelper.dbHelper.insertNewGame(gameModel);
    getGames();
  }

  updateGame(GameModel gameModel) async {
    await DbHelper.dbHelper.updateGame(gameModel);
    getGames();
  }

  updateIsFavorite(GameModel gameModel) {
    DbHelper.dbHelper.updateIsFavorite(gameModel);
    getGames();
  }

  deleteGame(GameModel gameModel) {
    DbHelper.dbHelper.deleteGame(gameModel);
    getGames();
  }
}
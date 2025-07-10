import 'dart:io';
import 'package:flutter/material.dart';
import '../data_repository/dbhelper.dart';
import '../models/game_model.dart';

class GameProvider extends ChangeNotifier {
  GameProvider() {
    getGames(); // Ambil data game saat provider diinisialisasi
  }

  bool isDark = false;
  File? image; // File image yang diambil dari kamera/galeri
  int adminID = 1; // Default adminID

  // Toggle tema gelap/terang
  void changeIsDark() {
    isDark = !isDark;
    notifyListeners();
  }

  // Controller untuk input data game
  final TextEditingController gameCodeController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController genreController = TextEditingController();
  final TextEditingController platformController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController releaseDateController = TextEditingController();
  final TextEditingController developerController = TextEditingController();
  final TextEditingController publisherController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController videoLinkController = TextEditingController();

  List<GameModel> allGames = [];
  List<GameModel> favoriteGames = [];

  // Ambil semua data game dari DB
  Future<void> getGames() async {
    allGames = await DbHelper.dbHelper.getAllGames();
    favoriteGames = allGames.where((g) => g.isFavorite).toList();
    notifyListeners();
  }

  // Masukkan game baru
  Future<void> insertNewGame() async {
    final game = GameModel(
      gameCode: gameCodeController.text,
      title: titleController.text,
      genre: genreController.text,
      platform: platformController.text,
      price: int.tryParse(priceController.text) ?? 0,
      releaseDate: releaseDateController.text,
      developer: developerController.text,
      publisher: publisherController.text,
      description: descriptionController.text,
      image: image?.path ?? '', // Path gambar disimpan sebagai String
      videoLink: videoLinkController.text,
      adminID: adminID,
      isFavorite: false,
    );

    await DbHelper.dbHelper.insertNewGame(game);
    clearControllers();
    getGames();
  }

  // Update game yang sudah ada
  Future<void> updateGame(GameModel game) async {
    await DbHelper.dbHelper.updateGame(game);
    getGames();
  }

  // Ubah status favorite
  Future<void> updateIsFavorite(GameModel game) async {
    game.isFavorite = !game.isFavorite;
    await DbHelper.dbHelper.updateGame(game);
    getGames();
  }

  // Hapus game berdasarkan ID
  Future<void> deleteGame(GameModel game) async {
    await DbHelper.dbHelper.deleteGame(game.gameID!);
    getGames();
  }

  // Set controller dari model game (saat edit)
  void setControllersFromGame(GameModel game) {
    gameCodeController.text = game.gameCode;
    titleController.text = game.title;
    genreController.text = game.genre;
    platformController.text = game.platform;
    priceController.text = game.price.toString();
    releaseDateController.text = game.releaseDate;
    developerController.text = game.developer;
    publisherController.text = game.publisher;
    descriptionController.text = game.description;
    videoLinkController.text = game.videoLink;
    image = File(game.image); // Asumsikan path valid
  }

  // Reset semua controller
  void clearControllers() {
    gameCodeController.clear();
    titleController.clear();
    genreController.clear();
    platformController.clear();
    priceController.clear();
    releaseDateController.clear();
    developerController.clear();
    publisherController.clear();
    descriptionController.clear();
    videoLinkController.clear();
    image = null;
  }
}

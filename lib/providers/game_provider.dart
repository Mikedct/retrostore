import 'dart:io';
import 'package:flutter/material.dart';
import '../data_repository/dbhelper.dart';
import '../models/game_model.dart';

class RecipeClass extends ChangeNotifier {
  RecipeClass() {
    getRecipes();
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

  List<RecipeModel> allRecipes = [];
  List<RecipeModel> favoriteRecipes = [];

  getRecipes() async {
    allRecipes = await DbHelper.dbHelper.getAllRecipes();
    favoriteRecipes = allRecipes.where((e) => e.isFavorite).toList();
    notifyListeners();
  }

  insertNewRecipe() {
    RecipeModel recipeModel = RecipeModel(
      nama: namaController.text,
      isFavorite: false,
      image: image,
      bahan: bahanController.text,
      langkah: langkahController.text,
      durasiMasak: int.parse(durasiMasakController.text != ''
          ? durasiMasakController.text
          : '0'),
    );
    DbHelper.dbHelper.insertNewRecipe(recipeModel);
    getRecipes();
  }

  updateRecipe(RecipeModel recipeModel) async {
    await DbHelper.dbHelper.updateRecipe(recipeModel);
    getRecipes();
  }

  updateIsFavorite(RecipeModel recipeModel) {
    DbHelper.dbHelper.updateIsFavorite(recipeModel);
    getRecipes();
  }

  deleteRecipe(RecipeModel recipeModel) {
    DbHelper.dbHelper.deleteRecipe(recipeModel);
    getRecipes();
  }
}
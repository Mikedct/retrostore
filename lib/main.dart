import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../ui/screens/favorite_game_screen.dart';
import '../ui/screens/main_game_screen.dart';
import '../ui/screens/new_game_screen.dart';
import '../ui/screens/splash_screen.dart';
import 'data_repository/dbhelper.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.dbHelper.initDatabase();
  runApp (const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
    Widget build (BuildContext context) {
      return MultiProvider (providers: [
        ChangeNotifierProvider<RecipeClass>(
          create: (context) => RecipeClass(),
        ), // Change NotifierProvider
      ],
    child: const InitApp()); // MultiProvider
  }
}
class InitApp extends StatelessWidget {
  const InitApp({super.key});
  
  @override
  Widget build (BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: Provider.of<RecipeClass> (context).isDark
      ? ThemeData.dark()
      : ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.blue[200],
        dialogTheme: const DialogThemeData(
        backgroundColor: Colors.blueAccent, // adjust as needed
        elevation: 5,
      ),
        primaryColor: Colors.blue [200]),
  // Theme Data
      title: 'gsk',
      home: const SplashScreen(),
      routes: {
        '/favorite_recipes_screen': (context) => const FavoriteRecipesScreen(),
        '/new_recipe_screen': (context) => const NewRecipeScreen(),
        '/main_recipe_screen': (context) => const MainRecipeScreen(),
      },
    ); // MaterialApp
  }
}
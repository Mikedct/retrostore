import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retrostore/providers/game_provider.dart';
import 'package:retrostore/ui/screens/favorite_game_screen.dart';
import 'package:retrostore/ui/screens/main_game_screen.dart';
import 'package:retrostore/ui/screens/new_game_screen.dart';
import 'package:retrostore/ui/screens/splash_screen.dart';
import 'data_repository/dbhelper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.dbHelper.initDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GameProvider>(
      create: (context) => GameProvider(),
      child: const InitApp(),
    );
  }
}

class InitApp extends StatelessWidget {
  const InitApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<GameProvider>().isDark;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RetroStore',
      theme: isDark
          ? ThemeData.dark()
          : ThemeData(
              primarySwatch: Colors.blue,
              scaffoldBackgroundColor: Colors.blue[100],
              dialogTheme: const DialogThemeData(
              backgroundColor: Colors.blueAccent, // adjust as needed
              elevation: 5,
      ),
        primaryColor: Colors.blue [200]),
      // Theme Data
      home: const SplashScreen(),
      routes: {
        '/main_game_screen': (context) => const MainGameScreen(),
        '/favorite_games_screen': (context) => const FavoriteGamesScreen(),
        '/new_game_screen': (context) => const NewGameScreen(),
      },
    );
  }
}


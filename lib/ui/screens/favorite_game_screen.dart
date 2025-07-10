import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retrostore/providers/game_provider.dart';
import 'package:retrostore/ui/screens/search_game_screen.dart';
import 'package:retrostore/ui/widgets/drawer.dart';
import 'package:retrostore/ui/widgets/game_widget.dart';
import 'package:retrostore/ui/widgets/popup_menu_button.dart';

class FavoriteGamesScreen extends StatelessWidget {
  const FavoriteGamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('RetroStore'),
                const SizedBox(height: 4),
                Text(
                  'Game Favorit',
                  style: TextStyle(
                    fontSize: 16,
                    color: provider.isDark
                        ? Colors.pink[100]
                        : const Color.fromARGB(255, 244, 143, 177),
                  ),
                ),
              ],
            ),
            actions: [
              InkWell(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SearchGameScreen(
                      games: provider.allGames
                          .where((g) => g.isFavorite)
                          .toList(),
                    ),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Icon(Icons.search),
                ),
              ),
              const MyPopupMenuButton(),
            ],
          ),
          drawer: const DrawerList(),
          body: provider.allGames.where((g) => g.isFavorite).isEmpty
              ? const Center(
                  child: Text(
                    'Belum ada game favorit 😔',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : ListView.builder(
                  itemCount:
                      provider.allGames.where((g) => g.isFavorite).length,
                  itemBuilder: (context, index) {
                    final favoriteGame = provider.allGames
                        .where((g) => g.isFavorite)
                        .toList()[index];
                    return GameWidget(favoriteGame);
                  },
                ),
        );
      },
    );
  }
}

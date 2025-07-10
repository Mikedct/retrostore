import 'package:retrostore/ui/screens/search_game_screen.dart';
import 'package:retrostore/ui/widgets/drawer.dart';
import 'package:retrostore/ui/widgets/popup_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/game_provider.dart';
import '../widgets/game_widget.dart';

class FavoriteGamesScreen extends StatelessWidget {
  const FavoriteGamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameClass>(
      builder: (BuildContext context, myProvider, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Resep'),
                const SizedBox(height: 4),
                Text(
                  'Resep Favorit',
                  style: TextStyle(
                    fontSize: 16,
                    color: !myProvider.isDark
                        ? const Color.fromARGB(255, 244, 143, 177)
                        : null,
                  ),
                ),
              ],
            ),
            actions: [
              InkWell(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: ((context) => SearchGameScreen(
                          games: myProvider.favoriteGames,
                        )),
                  ),
                ),
                child: const Icon(Icons.search),
              ),
              MyPopupMenuButton(),
            ],
          ),
          drawer: Drawer(
            child: DrawerList(),
          ),
          body: ListView.builder(
            itemCount: myProvider.favoriteGames.length,
            itemBuilder: (context, index) {
              return GameWidget(myProvider.favoriteGames[index]);
            },
          ),
        );
      },
    );
  }
}
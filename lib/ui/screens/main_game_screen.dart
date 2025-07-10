import 'package:retrostore/ui/widgets/drawer.dart';
import 'package:retrostore/ui/widgets/popup_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retrostore/providers/game_provider.dart';
import 'package:retrostore/ui/screens/search_game_screen.dart';
import '../widgets/game_widget.dart';
// test
class MainGameScreen extends StatelessWidget {
  const MainGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameClass>(
      builder: (BuildContext context, myProvider, Widget? child) => Scaffold(
        appBar: AppBar(
          title: const Text('List Game'),
          actions: [
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: ((context) => SearchGameScreen(
                        games: myProvider.allGames,
                      )),
                ),
              ),
              child: const Icon(Icons.search),
            ),
            MyPopupMenuButton(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.pushNamed(context, '/new_game_screen');
            if (!context.mounted) return;
            Navigator.pushReplacementNamed(context, '/main_game_screen');
          },
          child: const Icon(Icons.add),
        ),
        drawer: Drawer(
          backgroundColor: !myProvider.isDark ? Colors.blue[200] : null,
          child: DrawerList(),
        ),
        body: ListView.builder(
          itemCount: myProvider.allGames.length,
          itemBuilder: (context, index) {
            return GameWidget(myProvider.allGames[index]);
          },
        ),
      ),
    );
  }
}
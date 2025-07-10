import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retrostore/providers/game_provider.dart';
import 'package:retrostore/ui/screens/search_game_screen.dart';
import 'package:retrostore/ui/widgets/drawer.dart';
import 'package:retrostore/ui/widgets/game_widget.dart';
import 'package:retrostore/ui/widgets/popup_menu_button.dart';

class MainGameScreen extends StatelessWidget {
  const MainGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, provider, _) => Scaffold(
        appBar: AppBar(
          title: const Text('RetroStore'),
          actions: [
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SearchGameScreen(
                    games: provider.allGames,
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
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.pushNamed(context, '/new_game_screen');
            // Tidak perlu pushReplacement jika data sudah otomatis ter-refresh
          },
          child: const Icon(Icons.add),
        ),
        drawer: Drawer(
          backgroundColor: !provider.isDark ? Colors.blue[200] : null,
          child: const DrawerList(),
        ),
        body: provider.allGames.isEmpty
            ? const Center(
                child: Text(
                  'Belum ada game ditambahkan.',
                  style: TextStyle(fontSize: 16),
                ),
              )
            : ListView.builder(
                itemCount: provider.allGames.length,
                itemBuilder: (context, index) {
                  return GameWidget(provider.allGames[index]);
                },
              ),
      ),
    );
  }
}

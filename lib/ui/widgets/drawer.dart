import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retrostore/providers/game_provider.dart';

class DrawerList extends StatefulWidget {
  const DrawerList({super.key});

  @override
  State<DrawerList> createState() => _DrawerListState();
}

class _DrawerListState extends State<DrawerList> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Consumer<GameProvider>(
      builder: (context, provider, _) => Drawer(
        child: Column(
          children: [
            const SizedBox(height: 50),
            const CircleAvatar(
              backgroundImage: AssetImage('img/RetroStore.png'),
              radius: 50,
            ),
            const SizedBox(height: 10),
            const Text(
              'RetroStore',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 20),
            const Divider(thickness: 1),
            ListTile(
              leading: Icon(Icons.home,
                  color: isDark ? Colors.white : Colors.black),
              title: const Text('Beranda'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/main_game_screen');
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite, color: Colors.red),
              title: const Text('Game Favorit'),
              onTap: () {
                Navigator.pushReplacementNamed(
                    context, '/favorite_games_screen');
              },
            ),
            const Divider(thickness: 1),
            ListTile(
              leading: Icon(Icons.settings,
                  color: isDark ? Colors.white : Colors.black),
              title: const Text('Pengaturan'),
              onTap: () {
                Navigator.pop(context); // Tutup drawer dulu
                Navigator.pushNamed(context, '/settings');
              },
            ),
            const Spacer(),
            const Divider(thickness: 1),
            ListTile(
              leading: Icon(
                isDark ? Icons.light_mode : Icons.dark_mode,
                color: isDark ? Colors.white : Colors.black,
              ),
              title: Text(isDark ? 'Light Mode' : 'Dark Mode'),
              onTap: () {
                provider.changeIsDark();
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

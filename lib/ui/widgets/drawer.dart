import 'package:retrostore/providers/game_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerList extends StatefulWidget {
  const DrawerList({super.key});

  @override
  State<DrawerList> createState() => _DrawerListState();
}

class _DrawerListState extends State<DrawerList> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Consumer<GameClass>(
      builder: (BuildContext context, myProvider, Widget? child) => Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 200,
            child: const Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('img/logo.png'),
                radius: 50,
              ),
            ),
          ),
          ListTile(
            title: const Text('Home'),
            leading: Icon(
              Icons.home,
              color: isDark ? Colors.white : Colors.black,
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/main_game_screen');
            },
          ),
          ListTile(
            title: const Text('Resep Favorit'),
            leading: const Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, '/favorite_games_screen');
            },
          ),
          const Divider(thickness: 1),
          ListTile(
            title: const Text('Daftar Belanja'),
            leading: Icon(
              Icons.shopping_cart,
              color: isDark ? Colors.white : Colors.black,
            ),
            onTap: () {},
          ),
          const Divider(thickness: 1),
          ListTile(
            title: Text(isDark ? 'Light Mode' : 'Dark Mode'),
            leading: Icon(
              isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
              color: isDark ? Colors.white : Colors.black,
            ),
            onTap: () {
              Provider.of<GameClass>(context, listen: false).changeIsDark();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
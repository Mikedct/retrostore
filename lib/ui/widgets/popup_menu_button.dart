import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retrostore/providers/game_provider.dart';

class MyPopupMenuButton extends StatelessWidget {
  const MyPopupMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<GameProvider>(context).isDark;

    return PopupMenuButton<int>(
      icon: const Icon(Icons.more_vert),
      color: isDark ? Colors.blue[200] : Colors.white,
      onSelected: (value) {
        switch (value) {
          case 0:
            // Buka drawer secara manual
            Scaffold.of(context).openDrawer();
            break;
          case 1:
            showAboutDialog(
              context: context,
              applicationName: 'RetroStore',
              applicationVersion: '1.0.0',
              applicationLegalese: '© 2025 RetroStore Team',
            );
            break;
          case 2:
            exit(0);
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 0,
          child: Text('Buka Menu'),
        ),
        const PopupMenuItem(
          value: 1,
          child: Text('Tentang'),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          value: 2,
          child: Row(
            children: const [
              Icon(Icons.exit_to_app_outlined, color: Colors.red),
              SizedBox(width: 10),
              Text('Keluar'),
            ],
          ),
        ),
      ],
    );
  }
}

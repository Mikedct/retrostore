import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retrostore/providers/game_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GameProvider>(context);
    final isDark = provider.isDark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
              color: Colors.orange,
            ),
            title: Text(isDark ? 'Gunakan Mode Terang' : 'Gunakan Mode Gelap'),
            onTap: () {
              provider.changeIsDark();
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline, color: Colors.blue),
            title: const Text('Tentang Aplikasi'),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'RetroStore',
                applicationVersion: '1.0.0',
                applicationLegalese: '© 2025 RetroStore Team',
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Colors.red),
            title: const Text('Keluar Aplikasi'),
            onTap: () => exit(0),
          ),
        ],
      ),
    );
  }
}

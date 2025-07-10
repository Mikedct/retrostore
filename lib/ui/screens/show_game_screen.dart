import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retrostore/models/game_model.dart';
import 'package:retrostore/providers/game_provider.dart';
import 'edit_game_screen.dart';

class ShowGameScreen extends StatelessWidget {
  final GameModel gameModel;

  const ShowGameScreen({super.key, required this.gameModel});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GameProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Game'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              provider.setControllersFromGame(gameModel);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditGameScreen(gameModel: gameModel),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Hapus Game'),
                  content: const Text('Yakin ingin menghapus game ini?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Batal'),
                    ),
                    TextButton(
                      onPressed: () {
                        provider.deleteGame(gameModel);
                        Navigator.pop(context); // Tutup dialog
                        Navigator.pop(context); // Kembali ke screen sebelumnya
                      },
                      child: const Text(
                        'Hapus',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: gameModel.image.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    File(gameModel.image),
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image, size: 100),
                  ),
                )
              : const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('img/logo.png'),
                ),

            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                gameModel.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            infoRow('Genre', gameModel.genre),
            infoRow('Platform', gameModel.platform),
            infoRow('Price', 'Rp ${gameModel.price}'),
            infoRow('Release Date', gameModel.releaseDate),
            infoRow('Developer', gameModel.developer),
            infoRow('Publisher', gameModel.publisher),
            infoRow('Video Link', gameModel.videoLink),
            const SizedBox(height: 16),
            const Text(
              'Deskripsi',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              gameModel.description,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}

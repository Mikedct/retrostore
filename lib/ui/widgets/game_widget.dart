import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retrostore/models/game_model.dart';
import 'package:retrostore/providers/game_provider.dart';
import 'package:retrostore/ui/screens/show_game_screen.dart';

class GameWidget extends StatelessWidget {
  final GameModel gameModel;
  const GameWidget(this.gameModel, {super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<GameProvider>(context).isDark;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ShowGameScreen(gameModel: gameModel),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[800] : Colors.blue[100],
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        padding: const EdgeInsets.all(4),
        child: ListTile(
          leading: (gameModel.image.isNotEmpty)
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    File(gameModel.image),
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image, size: 50),
                  ),
                )
              : Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[700] : Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Icon(Icons.videogame_asset, color: Colors.white),
                  ),
                ),
          title: Text(
            gameModel.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            'Genre: ${gameModel.genre} | Rp ${gameModel.price}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
            onPressed: () {
              Provider.of<GameProvider>(context, listen: false)
                  .updateIsFavorite(gameModel);
            },
            icon: Icon(
              gameModel.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}

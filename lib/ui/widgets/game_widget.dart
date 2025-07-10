import 'package:retrostore/providers/game_provider.dart';
import 'package:flutter/material.dart';
import 'package:retrostore/ui/screens/show_game_screen.dart';
import 'package:provider/provider.dart';
import '../../models/game_model.dart';

class GameWidget extends StatelessWidget {
  final GameModel gameModel;
  const GameWidget(this.gameModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) =>
              ShowGameScreen(gameModel: gameModel))),
        );
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(5), 
        child: ListTile(
          tileColor: !Provider.of<GameClass>(context).isDark
            ? Colors.blue[100]
            : null,
          leading: gameModel.image == null
            ? Container(
                decoration: BoxDecoration(
                  color: !Provider.of<GameClass>(context).isDark
                      ? Colors.blue
                      : null,
                  borderRadius: BorderRadius.circular(8)),
                width: 70,
                height: double.infinity,
                child: const Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage('img/logo.png'),
                  )))
                : Image.file(
                gameModel.image!,
                width: 70,
                height: double.infinity,
              ),
              title: Text(gameModel.nama),
              subtitle: Text('${gameModel.durasiMasak} mins'),
              trailing: InkWell(
                onTap: () {
                  Provider.of<GameClass>(context, listen: false).updateIsFavorite(gameModel);
                },
            child: gameModel.isFavorite
              ? const Icon(
                  Icons.favorite,
                  color: Colors.red,
                )
              : const Icon(
                  Icons.favorite_border,
                  color: Colors.red,
              ),
          ),
        ),
      ),
    );
  }
}
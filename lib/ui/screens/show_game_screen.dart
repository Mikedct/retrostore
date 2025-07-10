import 'package:flutter/material.dart';
import 'package:retrostore/models/game_model.dart';
import 'package:retrostore/providers/game_provider.dart';
import 'package:provider/provider.dart';
import 'edit_game_screen.dart';

class ShowGameScreen extends StatelessWidget {
  final GameModel gameModel;
  const ShowGameScreen({super.key, required this.gameModel});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameClass>(
      builder: (context, provider, child) => Scaffold(
        appBar: AppBar(
          actions: [
            InkWell(
              onTap: () {
                provider.namaController.text = gameModel.nama;
                provider.durasiMasakController.text =
                    gameModel.durasiMasak.toString();
                provider.bahanController.text = gameModel.bahan;
                provider.langkahController.text = gameModel.langkah;
                provider.image = gameModel.image;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) =>
                        EditGameScreen(gameModel: gameModel)),
                  ),
                );
              },
              child: const Icon(Icons.edit),
            ),
            const SizedBox(width: 20),
            InkWell(
              onTap: () {
                provider.deleteGame(gameModel);
                Navigator.pop(context);
              },
              child: const Icon(Icons.delete),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: !Provider.of<GameClass>(context).isDark
                      ? Colors.blue[100]
                      : null,
                  borderRadius: BorderRadius.circular(5),
                ),
                height: 170,
                child: gameModel.image == null
                    ? const Center(
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('img/logo.png'),
                        ),
                      )
                    : Image.file(gameModel.image!),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  gameModel.nama,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: !Provider.of<GameClass>(context).isDark
                      ? Colors.blue[100]
                      : null,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Text(
                      'Durasi Masak :',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${gameModel.durasiMasak} menit',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: !Provider.of<GameClass>(context).isDark
                      ? Colors.blue[100]
                      : null,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Bahan :',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      gameModel.bahan,
                      style: const TextStyle(fontSize: 26),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: !Provider.of<GameClass>(context).isDark
                      ? Colors.blue[100]
                      : null,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Langkah :',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      gameModel.langkah,
                      style: const TextStyle(fontSize: 26),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
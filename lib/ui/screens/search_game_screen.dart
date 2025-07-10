import 'package:flutter/material.dart';
import 'package:retrostore/models/game_model.dart';
import 'package:retrostore/ui/widgets/game_widget.dart';

// ignore: must_be_immutable
class SearchGameScreen extends StatefulWidget {
  final List<GameModel> games;
  List<GameModel> filteredGames = [];

  SearchGameScreen({super.key, required this.games}) {
    filteredGames = games;
  }

  @override
  State<SearchGameScreen> createState() => _SearchGameScreenState();
}

class _SearchGameScreenState extends State<SearchGameScreen> {
  void filterGames(String value) {
    setState(() {
      widget.filteredGames = widget.games
          .where((game) =>
              game.title.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: filterGames,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            hintText: "Cari Resep",
            hintStyle: TextStyle(color: Colors.white),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: widget.filteredGames.isNotEmpty
            ? ListView.builder(
                itemCount: widget.filteredGames.length,
                itemBuilder: (BuildContext context, int index) {
                  return GameWidget(widget.filteredGames[index]);
                },
              )
            : const Center(
                child: Text('Resep tidak ditemukan'),
              ),
      ),
    );
  }
}

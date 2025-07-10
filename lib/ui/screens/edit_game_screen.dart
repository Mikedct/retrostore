import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../models/game_model.dart';
import '../../providers/game_provider.dart';

class EditGameScreen extends StatefulWidget {
  final GameModel gameModel;
  const EditGameScreen({super.key, required this.gameModel});

  @override
  State<EditGameScreen> createState() => _EditGameScreenState();
}

class _EditGameScreenState extends State<EditGameScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<GameProvider>(context, listen: false);

    provider.titleController.text = widget.gameModel.title;
    provider.genreController.text = widget.gameModel.genre;
    provider.platformController.text = widget.gameModel.platform;
    provider.priceController.text = widget.gameModel.price.toString();
    provider.releaseDateController.text = widget.gameModel.releaseDate;
    provider.developerController.text = widget.gameModel.developer;
    provider.publisherController.text = widget.gameModel.publisher;
    provider.descriptionController.text = widget.gameModel.description;
    provider.videoLinkController.text = widget.gameModel.videoLink;

    // Pastikan path gambar valid
    if (widget.gameModel.image != null &&
        widget.gameModel.image !.isNotEmpty &&
        File(widget.gameModel.image!).existsSync()) {
      provider.image = File(widget.gameModel.image!);
    } else {
      provider.image = null;
    }
  }

  Future pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null || !mounted) return;
    Provider.of<GameProvider>(context, listen: false).image = File(image.path);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Game')),
      body: Consumer<GameProvider>(
        builder: (context, provider, _) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                buildTextField('Title', provider.titleController),
                buildTextField('Genre', provider.genreController),
                buildTextField('Platform', provider.platformController),
                buildTextField('Price', provider.priceController, keyboardType: TextInputType.number),
                buildTextField('Release Date (yyyy-mm-dd)', provider.releaseDateController),
                buildTextField('Developer', provider.developerController),
                buildTextField('Publisher', provider.publisherController),
                buildTextField('Description', provider.descriptionController, maxLines: 3),
                buildTextField('Video Link', provider.videoLinkController),

                const SizedBox(height: 20),
                Row(
                  children: [
                    PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          onTap: () => pickImage(ImageSource.camera),
                          child: const Text("Ambil dari Kamera"),
                        ),
                        PopupMenuItem(
                          onTap: () => pickImage(ImageSource.gallery),
                          child: const Text("Ambil dari Galeri"),
                        ),
                      ],
                      child: const Icon(Icons.add_a_photo),
                    ),
                    const SizedBox(width: 10),
                    const Text("Pilih Gambar Game"),
                  ],
                ),

                const SizedBox(height: 10),
                if (provider.image != null)
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image.file(
                        provider.image!,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                      IconButton(
                        icon: const Icon(Icons.cancel, color: Colors.red),
                        onPressed: () {
                          provider.image = null;
                          setState(() {});
                        },
                      ),
                    ],
                  ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Update isi model
                      widget.gameModel
                        ..title = provider.titleController.text
                        ..genre = provider.genreController.text
                        ..platform = provider.platformController.text
                        ..price = int.tryParse(provider.priceController.text) ?? 0
                        ..releaseDate = provider.releaseDateController.text
                        ..developer = provider.developerController.text
                        ..publisher = provider.publisherController.text
                        ..description = provider.descriptionController.text
                        ..videoLink = provider.videoLinkController.text
                        ..image = provider.image?.path ?? '';

                      provider.updateGame(widget.gameModel);
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Simpan Perubahan'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller,
      {int maxLines = 1, TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}

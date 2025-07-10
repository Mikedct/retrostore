import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../providers/game_provider.dart';

class NewGameScreen extends StatefulWidget {
  const NewGameScreen({super.key});

  @override
  State<NewGameScreen> createState() => _NewGameScreenState();
}

class _NewGameScreenState extends State<NewGameScreen> {
  final _formKey = GlobalKey<FormState>();

  Future pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    if (!mounted) return;
    Provider.of<GameProvider>(context, listen: false).image = File(image.path);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Game'),
      ),
      body: Consumer<GameProvider>(
        builder: (context, provider, _) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                buildTextField('Game Code', provider.gameCodeController),
                buildTextField('Title', provider.titleController),
                buildTextField('Genre', provider.genreController),
                buildTextField('Platform', provider.platformController),
                buildTextField('Price', provider.priceController,
                    keyboardType: TextInputType.number),
                buildTextField('Release Date (yyyy-mm-dd)',
                    provider.releaseDateController),
                buildTextField('Developer', provider.developerController),
                buildTextField('Publisher', provider.publisherController),
                buildTextField('Description', provider.descriptionController,
                    maxLines: 3),
                buildTextField('Video Link', provider.videoLinkController),

                const SizedBox(height: 20),

                Row(
                  children: [
                    PopupMenuButton(
                      color: !provider.isDark ? Colors.blue[100] : null,
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          onTap: () => pickImage(ImageSource.camera),
                          child: Row(
                            children: const [
                              Icon(Icons.camera_alt),
                              SizedBox(width: 5),
                              Text('Ambil dari Kamera'),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () => pickImage(ImageSource.gallery),
                          child: Row(
                            children: const [
                              Icon(Icons.image),
                              SizedBox(width: 5),
                              Text('Pilih dari Galeri'),
                            ],
                          ),
                        ),
                      ],
                      child: const Icon(Icons.add_a_photo),
                    ),
                    const SizedBox(width: 10),
                    const Text('Tambah Gambar'),
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

                const SizedBox(height: 30),

                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      provider.insertNewGame();
                      provider.clearControllers();
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Simpan'),
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
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label tidak boleh kosong';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}

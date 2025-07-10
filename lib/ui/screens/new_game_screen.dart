import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../providers/game_provider.dart';

class NewRecipeScreen extends StatefulWidget {
  const NewRecipeScreen({super.key});

  @override
  State<NewRecipeScreen> createState() => _NewRecipeScreenState();
}

class _NewRecipeScreenState extends State<NewRecipeScreen> {
  Future pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    if (!mounted) return;
    Provider.of<RecipeClass>(context, listen: false).image = File(image.path);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Resep'),
      ),
      body: Consumer<RecipeClass>(
        builder: (context, provider, child) => SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                TextField(
                  controller: provider.namaController,
                  decoration: InputDecoration(
                    label: const Text('Nama Resep'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: provider.durasiMasakController,
                  decoration: InputDecoration(
                    label: const Text('Durasi masak (menit)'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
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
                              Icon(Icons.camera_alt_outlined),
                              SizedBox(width: 5),
                              Text('Ambil Gambar'),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () => pickImage(ImageSource.gallery),
                          child: Row(
                            children: const [
                              Icon(Icons.image_outlined),
                              SizedBox(width: 5),
                              Text('Pilih gambar'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      'Tambah Gambar',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Visibility(
                  visible: provider.image != null,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          provider.image = null;
                          setState(() {});
                        },
                        child: const Icon(
                          Icons.cancel_outlined,
                          color: Colors.red,
                        ),
                      ),
                      provider.image != null
                          ? Image.file(
                              provider.image!,
                              width: 100,
                              height: 100,
                            )
                          : Container(),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SizedBox(
                    height: 100,
                    child: TextField(
                      expands: true,
                      maxLines: null,
                      controller: provider.bahanController,
                      decoration: InputDecoration(
                        label: const Text('Bahan'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SizedBox(
                    height: 100,
                    child: TextField(
                      expands: true,
                      maxLines: null,
                      controller: provider.langkahController,
                      decoration: InputDecoration(
                        label: const Text('Langkah'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    provider.insertNewRecipe();
                    provider.namaController.clear();
                    provider.durasiMasakController.clear();
                    provider.langkahController.clear();
                    provider.bahanController.clear();
                    provider.image = null;
                    Navigator.of(context).pop();
                  },
                  child: const Center(child: Text('Simpan')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
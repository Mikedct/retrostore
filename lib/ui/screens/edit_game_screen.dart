import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:retrostore/models/game_model.dart';
import 'package:provider/provider.dart';
import '../../providers/game_provider.dart';

class EditGameScreen extends StatefulWidget {
  final GameModel gameModel;
  const EditGameScreen({super.key, required this.gameModel});

  @override
  State<EditGameScreen> createState() => _EditGameScreenState();
}

class _EditGameScreenState extends State<EditGameScreen> {
  Future pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    if (!mounted) return;
    Provider.of<GameClass>(context, listen: false).image = File(image.path);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Resep'),
      ),
      body: Consumer<GameClass>(
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
                    label: const Text('Durasi Masak (menit)'),
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
                      itemBuilder: ((context) => [
                            PopupMenuItem(
                              onTap: () => pickImage(ImageSource.camera),
                              child: Row(
                                children: const [
                                  Icon(Icons.camera_alt_outlined),
                                  SizedBox(width: 5),
                                  Text('Ambil gambar'),
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
                          ]),
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
                    widget.gameModel.nama = provider.namaController.text;
                    widget.gameModel.durasiMasak = int.parse(
                      provider.durasiMasakController.text != ''
                          ? provider.durasiMasakController.text
                          : '0',);
                    widget.gameModel.image = provider.image;
                    widget.gameModel.bahan = provider.bahanController.text;
                    widget.gameModel.langkah = provider.langkahController.text;
                    provider.updateGame(widget.gameModel);
                    provider.namaController.clear();
                    provider.durasiMasakController.clear();
                    provider.bahanController.clear();
                    provider.langkahController.clear();
                    provider.image = null;

                    Navigator.of(context).pop();
                  },
                  child: const Center(child: Text('Simpan Perubahan')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
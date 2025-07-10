import 'dart:io';

class GameModel {
  int? id;
  late String nama;
  late bool isFavorite;
  File? image;
  late int durasiMasak;
  late String bahan;
  late String langkah;

  GameModel({
    this.id,
    required this.nama,
    required this.isFavorite,
    this.image,
    required this.durasiMasak,
    required this.bahan,
    required this.langkah,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'isFavorite': isFavorite ? 1 : 0,
      'durasiMasak': durasiMasak,
      'bahan': bahan,
      'langkah': langkah,
      'image': image == null ? '' : image!.path,
    };
  }

  factory GameModel.fromMap(Map<String, dynamic> map) {
    return GameModel(
      id: map['id'],
      nama: map['nama'],
      isFavorite: map['isFavorite'] == 1 ? true : false,
      durasiMasak: map['durasiMasak'],
      bahan: map['bahan'],
      langkah: map['langkah'],
      image: map['image'] != null ? File(map['image']) : null,
    );
  }
}
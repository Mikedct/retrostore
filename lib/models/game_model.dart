class GameModel {
  int? gameID;
  String gameCode;
  String title;
  String genre;
  String platform;
  int price;
  String releaseDate;
  String developer;
  String publisher;
  String description;
  String image;
  String videoLink;
  int adminID;
  bool isFavorite;

  GameModel({
    this.gameID,
    required this.gameCode,
    required this.title,
    required this.genre,
    required this.platform,
    required this.price,
    required this.releaseDate,
    required this.developer,
    required this.publisher,
    required this.description,
    required this.image,
    required this.videoLink,
    required this.adminID,
    required this.isFavorite,
  });

  factory GameModel.fromMap(Map<String, dynamic> map) {
    return GameModel(
      gameID: map['gameID'],
      gameCode: map['gameCode'],
      title: map['title'],
      genre: map['genre'],
      platform: map['platform'],
      price: map['price'],
      releaseDate: map['releaseDate'],
      developer: map['developer'],
      publisher: map['publisher'],
      description: map['description'],
      image: map['image'],
      videoLink: map['videoLink'],
      adminID: map['adminID'],
      isFavorite: map['isFavorite'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (gameID != null) 'gameID': gameID,
      'gameCode': gameCode,
      'title': title,
      'genre': genre,
      'platform': platform,
      'price': price,
      'releaseDate': releaseDate,
      'developer': developer,
      'publisher': publisher,
      'description': description,
      'image': image,
      'videoLink': videoLink,
      'adminID': adminID,
      'isFavorite': isFavorite ? 1 : 0,
    };
  }
}

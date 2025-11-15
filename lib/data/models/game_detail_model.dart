import 'package:gamerpedia_app/domain/entities/game.dart';

class GameDetailModel {
  final int id;
  final String name;
  final String? backgroundImage;
  final double? rating;
  final int? metacritic;
  final String? description;
  final List<String>? genres;
  final List<String>? platforms;
  final String? esrbRating;
  final String? developer;
  final String? trailer;

  GameDetailModel({
    required this.id,
    required this.name,
    this.backgroundImage,
    this.rating,
    this.metacritic,
    this.description,
    this.genres,
    this.platforms,
    this.esrbRating,
    this.developer,
    this.trailer,
  });

  factory GameDetailModel.fromJson(Map<String, dynamic> json) {
    return GameDetailModel(
      id: json['id'],
      name: json['name'],
      backgroundImage: json['background_image'],
      rating: (json['rating'] as num?)?.toDouble(),
      metacritic: json['metacritic'],
      description: json['description_raw'],
      genres: json['genres'] != null
          ? List<String>.from(json['genres'].map((g) => g['name']))
          : null,
      platforms: json['platforms'] != null
          ? List<String>.from(
              json['platforms'].map((p) => p['platform']['name']),
            )
          : null,
      esrbRating: json['esrb_rating']?['name'],
      developer: json['developers'] != null && json['developers'].isNotEmpty
          ? json['developers'][0]['name']
          : null,
      trailer: json['clip']?['clip'], // Puede ser null
    );
  }

  Game toEntity() {
    return Game(
      id: id,
      name: name,
      imageUrl: backgroundImage,
      rating: rating,
      metacritic: metacritic,
      description: description,
      genres: genres,
      platforms: platforms,
      esrbRating: esrbRating,
      developer: developer,
      trailerUrl: trailer,
    );
  }
}

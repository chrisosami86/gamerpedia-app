import 'package:gamerpedia_app/domain/entities/game.dart';

class GameModel {
  final int id;
  final String name;
  final String? backgroundImage;
  final double? rating;
  final int? metacritic;
  final List<String>? genres;
  final List<String>? platforms;

  GameModel({
    required this.id,
    required this.name,
    this.backgroundImage,
    this.rating,
    this.metacritic,
    this.genres,
    this.platforms,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      id: json['id'],
      name: json['name'],
      backgroundImage: json['background_image'],
      rating: (json['rating'] is int)
          ? (json['rating'] as int).toDouble()
          : (json['rating'] as num?)?.toDouble(),
      metacritic: json['metacritic'],
      genres: json['genres'] != null
          ? List<String>.from(json['genres'].map((g) => g['name']))
          : null,
      platforms: json['platforms'] != null
          ? List<String>.from(
              json['platforms'].map((p) => p['platform']['name']),
            )
          : null,
    );
  }

  Game toEntity() {
    return Game(
      id: id,
      name: name,
      imageUrl: backgroundImage,
      rating: rating,
      metacritic: metacritic,
      genres: genres,
      platforms: platforms,
    );
  }
}

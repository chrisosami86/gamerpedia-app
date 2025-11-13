class Game {
  final int id;
  final String name;
  final String? imageUrl;
  final String? description;
  final double? rating;
  final int? metacritic;
  final List<String>? genres;
  final List<String>? platforms;
  final String? esrbRating;
  final String? developer;
  final String? trailerUrl;

  Game({
    required this.id,
    required this.name,
    this.imageUrl,
    this.description,
    this.rating,
    this.metacritic,
    this.genres,
    this.platforms,
    this.esrbRating,
    this.developer,
    this.trailerUrl,
  });
}


//Esta entidad NO sabe nada del JSON.
//La capa data la convertirá desde API a entidad.
import '../entities/game.dart';
import '../repositories/game_repository.dart';

class SearchGames {
  final GameRepository repository;

  SearchGames(this.repository);

  Future<List<Game>> call(String query) {
    return repository.searchGames(query);
  }
}

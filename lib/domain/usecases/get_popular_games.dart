import '../repositories/game_repository.dart';
import '../entities/game.dart';

class GetPopularGames {
  final GameRepository repository;

  GetPopularGames(this.repository);

  Future<List<Game>> call() {
    return repository.getPopularGames();
  }
}

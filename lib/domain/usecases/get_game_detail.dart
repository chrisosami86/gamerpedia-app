import '../repositories/game_repository.dart';
import '../entities/game.dart';

class GetGameDetail {
  final GameRepository repository;

  GetGameDetail(this.repository);

  Future<Game> call(int id) {
    return repository.getGameDetail(id);
  }
}

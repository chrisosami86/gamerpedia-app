import '../entities/game.dart';

abstract class GameRepository {
  Future<List<Game>> getPopularGames();
  Future<Game> getGameDetail(int id);
}


//Esto define lo que la app necesita, no cómo se obtiene.
//La implementación concreta irá en data/.
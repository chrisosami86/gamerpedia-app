import '../entities/game.dart';

abstract class GameRepository {
  Future<List<Game>> getPopularGames();
  Future<Game> getGameDetail(int id);
  Future<List<Game>> searchGames(String query);
}


//Esto define lo que la app necesita, no cómo se obtiene.
//La implementación concreta irá en data/.
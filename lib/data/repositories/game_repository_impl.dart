import 'package:gamerpedia_app/data/datasources/game_api_service.dart';
import 'package:gamerpedia_app/data/models/game_model.dart';
import 'package:gamerpedia_app/data/models/game_detail_model.dart';
import 'package:gamerpedia_app/domain/entities/game.dart';
import 'package:gamerpedia_app/domain/repositories/game_repository.dart';

class GameRepositoryImpl implements GameRepository {
  final GameApiService api;

  GameRepositoryImpl(this.api);

  @override
  Future<List<Game>> getPopularGames() async {
    final json = await api.getJson("games?ordering=-rating");

    final results = (json['results'] as List)
        .map((e) => GameModel.fromJson(e).toEntity())
        .toList();

    return results;
  }

  @override
  Future<Game> getGameDetail(int id) async {
    final json = await api.getJson("games/$id?");

    return GameDetailModel.fromJson(json).toEntity();
  }

  @override
  Future<List<Game>> searchGames(String query) async {
    final json = await api.searchGames(query);
    final results = json["results"] as List;

    return results.map((e) => GameModel.fromJson(e).toEntity()).toList();
  }
}

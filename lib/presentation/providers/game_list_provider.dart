import 'package:flutter/material.dart';
import 'package:gamerpedia_app/domain/entities/game.dart';
import 'package:get_it/get_it.dart';
import '../../domain/usecases/get_popular_games.dart';

class GameListProvider extends ChangeNotifier {
  final _usecase = GetPopularGames(GetIt.I());

  List<Game> games = [];
  bool loading = false;

  Future<void> loadGames() async {
    loading = true;
    notifyListeners();

    games = await _usecase();
    loading = false;
    notifyListeners();
  }
}

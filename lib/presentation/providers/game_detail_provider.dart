import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:gamerpedia_app/domain/entities/game.dart';
import 'package:gamerpedia_app/domain/usecases/get_game_detail.dart';

class GameDetailProvider extends ChangeNotifier {
  final _usecase = GetGameDetail(GetIt.I());

  Game? game;
  bool loading = false;

  Future<void> loadGame(int id) async {
    loading = true;
    notifyListeners();

    game = await _usecase(id);

    loading = false;
    notifyListeners();
  }
}

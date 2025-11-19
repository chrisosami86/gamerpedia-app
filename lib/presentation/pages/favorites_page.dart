import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gamerpedia_app/presentation/providers/favorites_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:gamerpedia_app/domain/usecases/get_game_detail.dart';
import 'package:gamerpedia_app/presentation/widgets/game_card.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final fav = context.watch<FavoritesProvider>();
    final ids = fav.favoriteIds;

    return Scaffold(
      appBar: AppBar(title: const Text("Favoritos ⭐")),
      body: ids.isEmpty
          ? const Center(child: Text("No tienes favoritos aún"))
          : FutureBuilder(
              future: _loadFavoriteGames(ids),
              builder: (_, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final games = snapshot.data!;

                return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: games.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.70,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (_, index) {
                    return GameCard(game: games[index]);
                  },
                );
              },
            ),
    );
  }

  Future<List<dynamic>> _loadFavoriteGames(List<int> ids) async {
    final usecase = GetGameDetail(GetIt.I());
    List games = [];

    for (var id in ids) {
      final game = await usecase(id);
      games.add(game);
    }

    return games;
  }
}

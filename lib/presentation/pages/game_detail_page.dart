import 'package:flutter/material.dart';
import 'package:gamerpedia_app/presentation/providers/favorites_provider.dart';
import 'package:provider/provider.dart';
import 'package:gamerpedia_app/presentation/providers/game_detail_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GameDetailPage extends StatefulWidget {
  final int gameId;
  const GameDetailPage({super.key, required this.gameId});

  @override
  State<GameDetailPage> createState() => _GameDetailPageState();
}

class _GameDetailPageState extends State<GameDetailPage> {
  @override
  void initState() {
    super.initState();
    // Cargar el juego apenas entra a la pantalla
    Future.microtask(() {
      context.read<GameDetailProvider>().loadGame(widget.gameId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GameDetailProvider>();
    final game = provider.game;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalle del Juego"),
        actions: [
          Consumer<FavoritesProvider>(
            builder: (_, fav, __) {
              final isFav = fav.isFavorite(widget.gameId);

              return IconButton(
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: () {
                  fav.toggleFavorite(widget.gameId);
                },
              );
            },
          ),
        ],
      ),
      body: provider.loading
          ? const Center(child: CircularProgressIndicator())
          : game == null
          ? const Center(child: Text("No se encontró el juego"))
          : _buildDetail(game),
    );
  }

  Widget _buildDetail(game) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen grande
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: game.imageUrl ?? "",
              width: double.infinity,
              height: 220,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 16),

          // Nombre
          Text(
            game.name,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          // Rating y metacritic
          if (game.rating != null || game.metacritic != null)
            Row(
              children: [
                if (game.rating != null) Text("⭐ ${game.rating}  "),
                if (game.metacritic != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      "Metacritic: ${game.metacritic}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
              ],
            ),

          const SizedBox(height: 12),

          // Géneros
          if (game.genres != null)
            Text(
              "Géneros: ${game.genres!.join(", ")}",
              style: const TextStyle(fontSize: 14),
            ),

          const SizedBox(height: 8),

          // Plataformas
          if (game.platforms != null)
            Text(
              "Plataformas: ${game.platforms!.join(", ")}",
              style: const TextStyle(fontSize: 14),
            ),

          const SizedBox(height: 8),

          // ESRB
          if (game.esrbRating != null)
            Text(
              "Clasificación ESRB: ${game.esrbRating}",
              style: const TextStyle(fontSize: 14),
            ),

          const SizedBox(height: 8),

          // Developer
          if (game.developer != null)
            Text(
              "Desarrolladora: ${game.developer}",
              style: const TextStyle(fontSize: 14),
            ),

          const SizedBox(height: 16),

          // Descripción
          if (game.description != null)
            Text(
              game.description!,
              style: const TextStyle(fontSize: 15, height: 1.4),
            ),

          const SizedBox(height: 20),

          // TRAILER (si existe)
          if (game.trailerUrl != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Tráiler:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(game.trailerUrl!, fit: BoxFit.cover),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

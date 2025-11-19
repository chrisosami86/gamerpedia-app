import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gamerpedia_app/domain/entities/game.dart';
import 'package:gamerpedia_app/presentation/pages/game_detail_page.dart';

class GameCard extends StatelessWidget {
  final Game game;

  const GameCard({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => GameDetailPage(gameId: game.id)),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen del juego
            Expanded(
              child: CachedNetworkImage(
                imageUrl: game.imageUrl ?? "",
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: (_, __) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (_, __, ___) =>
                    const Center(child: Icon(Icons.image_not_supported)),
              ),
            ),

            // Nombre del juego
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                game.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),

            // Plataformas (texto)
            if (game.platforms != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  game.platforms!.join(" | "),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                ),
              ),

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gamerpedia_app/presentation/pages/about_page.dart';
import 'package:gamerpedia_app/presentation/pages/favorites_page.dart';
import 'package:provider/provider.dart';
import 'package:gamerpedia_app/presentation/providers/game_list_provider.dart';
import 'package:gamerpedia_app/presentation/widgets/game_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GameListProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("GameInfo App")),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "GameInfo App",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Menú principal",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Inicio"),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text("Favoritos"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FavoritesPage()),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.info),
              title: const Text("Acerca de"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AboutPage()),
                );
              },
            ),
          ],
        ),
      ),

      body: _buildBody(provider),
    );
  }

  Widget _buildBody(GameListProvider provider) {
    if (provider.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.games.isEmpty) {
      return const Center(child: Text("No se encontraron juegos 🕹️"));
    }

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: provider.games.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 columnas
        childAspectRatio: 0.70, // tamaño de las cards
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final game = provider.games[index];
        return GameCard(game: game);
      },
    );
  }
}

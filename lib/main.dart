import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gamerpedia_app/presentation/providers/game_detail_provider.dart';
import 'package:gamerpedia_app/presentation/providers/game_list_provider.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'presentation/pages/home_page.dart';
import 'presentation/providers/favorites_provider.dart';

import 'package:get_it/get_it.dart';
import 'data/datasources/game_api_service.dart';
import 'data/repositories/game_repository_impl.dart';
import 'domain/repositories/game_repository.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Cargar .env
  await dotenv.load(fileName: ".env");

  // Hive
  await Hive.initFlutter();
  await Hive.openBox('favorites');
  getIt.registerLazySingleton(() => GameApiService());

  getIt.registerLazySingleton<GameRepository>(
    () => GameRepositoryImpl(getIt<GameApiService>()),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider(create: (_) => GameListProvider()..loadGames()),
        ChangeNotifierProvider(create: (_) => GameDetailProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GameInfo App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const HomePage(),
      ),
    );
  }
}

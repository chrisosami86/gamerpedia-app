import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FavoritesProvider extends ChangeNotifier {
  final Box _box = Hive.box('favorites');

  List<int> get favoriteIds =>
      _box.get('ids', defaultValue: <int>[])!.cast<int>();

  bool isFavorite(int id) => favoriteIds.contains(id);

  void toggleFavorite(int id) {
    final ids = List<int>.from(favoriteIds);

    if (ids.contains(id)) {
      ids.remove(id);
    } else {
      ids.add(id);
    }

    _box.put('ids', ids);
    notifyListeners();
  }
}

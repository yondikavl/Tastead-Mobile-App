import 'package:flutter/foundation.dart';
import '../models/favorite_restaurant.dart';
import '../helpers/favorite_database_helper.dart';

class FavoriteProvider with ChangeNotifier {
  List<FavoriteRestaurant> _favorites = [];

  List<FavoriteRestaurant> get favorites => _favorites;

  Future<void> loadFavorites() async {
    _favorites = await FavoriteDatabaseHelper.instance.getFavorites();
    notifyListeners();
  }

  Future<void> addFavorite(FavoriteRestaurant restaurant) async {
    await FavoriteDatabaseHelper.instance.insertFavorite(restaurant);
    await loadFavorites();
  }

  Future<void> removeFavorite(String id) async {
    await FavoriteDatabaseHelper.instance.removeFavorite(id);
    await loadFavorites();
  }

  bool isFavorite(String id) {
    return _favorites.any((restaurant) => restaurant.id == id);
  }
}

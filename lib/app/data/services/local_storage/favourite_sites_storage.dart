import 'package:hive_flutter/hive_flutter.dart';
import '../../models/favourite_website/favourite_sites.dart';

class FavoriteSitesStorage {
  static const String _boxName = 'favorite_sites';
  static late Box<FavoriteSite> _box;

  static Future<void> init() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(FavoriteSiteAdapter());
    }
    _box = await Hive.openBox<FavoriteSite>(_boxName);
  }

  static List<FavoriteSite> getAllFavorites() {
    return _box.values.toList();
  }

  static Future<void> addFavorite(FavoriteSite site) async {
    await _box.add(site);
  }

  static Future<void> editFavorite(int index, FavoriteSite site) async {
    await _box.putAt(index, site);
  }

  static Future<void> removeFavorite(int index) async {
    await _box.deleteAt(index);
  }

  static Future<void> clearAll() async {
    await _box.clear();
  }
}
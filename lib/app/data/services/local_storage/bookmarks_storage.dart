// lib/app/data/services/local_storage/bookmark_storage.dart
import 'package:hive/hive.dart';
import '../../models/bookmarks_models/bookmark_models.dart';

class BookmarkStorage {
  static const String _boxName = 'bookmarks';

  static Future<void> init() async {
    Hive.registerAdapter(BookmarkAdapter());
    await Hive.openBox<Bookmark>(_boxName);
  }

  static Future<void> addBookmark(Bookmark bookmark) async {
    final box = Hive.box<Bookmark>(_boxName);
    await box.add(bookmark);
  }

  static List<Bookmark> getAllBookmarks() {
    final box = Hive.box<Bookmark>(_boxName);
    return box.values.toList();
  }

  static Future<void> deleteBookmark(int index) async {
    final box = Hive.box<Bookmark>(_boxName);
    await box.deleteAt(index);
  }
}

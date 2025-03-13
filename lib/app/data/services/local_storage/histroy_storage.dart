import 'package:hive/hive.dart';
import '../../models/history_model.dart';

class HistoryStorage {
  static const String _boxName = 'browser_history';
  static late Box<BrowserHistory> _box;

  static Future<void> init() async {
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(BrowserHistoryAdapter());
    }
    _box = await Hive.openBox<BrowserHistory>(_boxName);
  }

  static Future<void> addToHistory(BrowserHistory entry) async {
    await _box.add(entry);
  }

  static List<BrowserHistory> getAllHistory() {
    return _box.values.toList()
      ..sort((a, b) => b.visitTime.compareTo(a.visitTime));
  }

  static Future<void> clearHistory() async {
    await _box.clear();
  }

  static Future<void> deleteEntry(int index) async {
    await _box.deleteAt(index);
  }
}
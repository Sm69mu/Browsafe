// lib/app/data/services/tab_storage.dart
import 'package:hive/hive.dart';

import '../../models/browsertab_model.dart';

class TabStorage {
  static const String boxName = 'browser_tabs';
  
  static Future<void> init() async {
    await Hive.openBox<List>(boxName);
  }

  static Future<void> saveTabs(List<BrowserTab> tabs) async {
    final box = Hive.box<List>(boxName);
    final tabsJson = tabs.map((tab) => tab.toJson()).toList();
    await box.put('tabs', tabsJson);
  }

  static List<BrowserTab> loadTabs() {
    final box = Hive.box<List>(boxName);
    final tabsJson = box.get('tabs', defaultValue: []);
    return (tabsJson as List).map((json) => 
      BrowserTab.fromJson(Map<String, dynamic>.from(json))).toList();
  }
}
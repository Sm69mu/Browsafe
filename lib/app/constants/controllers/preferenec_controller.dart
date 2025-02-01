import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserPreferencesController extends GetxController {
  late Box _box;
  static const String _boxName = 'preferences';

  // Keys for storing preferences
  static const baseUrlKey = 'BASE_URL';
  static const userId = "USER_ID";
  static const loginStatus = "LOGIN_STATUS";
  static const isFirstopen = "IS_FIRST_OPEN";
  static const isNewsEnabled = "IS_NEWS_ENABLED";

  @override
  void onInit() async {
    super.onInit();
    // Initialize Hive and open the box
    await Hive.initFlutter();
    _box = await Hive.openBox(_boxName);
  }

  // Base URL methods
  Future<void> setBaseUrl(String url) async {
    await _box.put(baseUrlKey, url);
  }

  String get baseUrl => _box.get(baseUrlKey, defaultValue: "");

  // First open methods
  bool get isFirstOpen => _box.get(isFirstOpen, defaultValue: true);

  Future<void> setFirstOpenCompleted() async {
    await _box.put(isFirstOpen, false);
  }

  // User ID methods
  Future<void> setUserId(String id) async {
    await _box.put(userId, id);
  }

  String get userID => _box.get(userId, defaultValue: "");


  // Login status methods
  Future<void> changeLoginState(bool state) async {
    await _box.put(loginStatus, state);
  }

  bool get loginState => _box.get(loginStatus, defaultValue: false);

  // News enabled methods
  Future<void> changeNewsState(bool state) async {
    await _box.put(isNewsEnabled, state);
  }

  bool get newsState => _box.get(isNewsEnabled, defaultValue: true);

  // Clear all preferences
  Future<void> clearPreferences() async {
    await _box.clear();
  }
}

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesConfig {
  static SharedPreferences? _preferences;

  static Future<void> initialize() async {
    try {
      _preferences = await SharedPreferences.getInstance();
    } catch (e) {
      print('SharedPreferences initialization error: $e');
      // Handle initialization error, if any
    }
  }

  static Future<void> saveWelcome(String key, bool value) async {
    await _preferences?.setBool(key, value);
  }

  static bool? getWelcome(String key) {
    return _preferences?.getBool(key);
  }
}

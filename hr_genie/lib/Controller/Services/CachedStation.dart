import 'package:shared_preferences/shared_preferences.dart';

class CacheStore {
  Future<String?>? getCache(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final result = prefs.getString(key);
    return result;
  }

  Future<void> setCache(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
    print("Setting Cached Key: $key Value: $value");
  }

  Future<void> removeCache(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
    print("Removed Cached Key: $key");
  }
}

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  Future<String?> read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String? result = prefs.getString(key);
    return result;
  }

  readList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? results = prefs.getStringList(key);
    return results;
  }

  save(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  saveList(String key, List<String> values) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, values);
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}

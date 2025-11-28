import 'package:shared_preferences/shared_preferences.dart';

class SessionStorage {
  /// Salva qualquer mapa de dados no SharedPreferences
  static Future<void> saveData(Map<String, String?> data) async {
    final prefs = await SharedPreferences.getInstance();
    for (var entry in data.entries) {
      if (entry.value != null) {
        await prefs.setString(entry.key, entry.value!);
      }
    }
  }

  /// Carrega dados do SharedPreferences com base nas chaves fornecidas
  static Future<Map<String, String?>> loadData(List<String> keys) async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, String?> loadedData = {};
    for (var key in keys) {
      loadedData[key] = prefs.getString(key);
    }
    return loadedData;
  }

  /// Limpa dados específicos do SharedPreferences
  static Future<void> clearData(List<String> keys) async {
    final prefs = await SharedPreferences.getInstance();
    for (var key in keys) {
      await prefs.remove(key);
    }
  }

  /// Limpa todo o SharedPreferences
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}

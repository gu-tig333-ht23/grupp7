import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/model_partyview_ledamot.dart';

class CacheManager {
  // used to cache list of Ledamot
  static const String _prefix = 'cache_';

  Future<void> setCache(String key, List<Ledamot> value) async {
    final prefs = await SharedPreferences.getInstance();

    try {
      // Convert the list of Ledamot to a list of JSON
      final List<Map<String, dynamic>> jsonList =
          value.map((ledamot) => ledamot.toJson()).toList();

      // Convert the list of JSON to a JSON string
      final jsonString = json.encode(jsonList);

      prefs.setString('$_prefix$key', jsonString);
    } catch (e) {
      print('Error encoding ledamot list: $e');
    }
  }

  Future<List<Ledamot>> getCache(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final cachedValue = prefs.getString('$_prefix$key');

    if (cachedValue != null) {
      final List<dynamic> cachedList = json.decode(cachedValue);

      // Convert the list of JSON to a list of Ledamot
      List<Ledamot> ledamotList =
          cachedList.map((json) => Ledamot.fromJson(json)).toList();

      return ledamotList;
    } else {
      return []; // Return an empty list or handle the absence of cached data
    }
  }

  Future<void> clearCache(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('$_prefix$key');
  }
}

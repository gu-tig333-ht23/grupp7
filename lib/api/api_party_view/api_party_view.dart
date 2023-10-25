import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/model_party_view_ledamot.dart';
import '../../models/model_party_view_ledamotresult.dart';
import 'cache_manager.dart';

Future<List<Ledamot>> fetchLedamotList(selectedParty) async {
  // Gets all active party members including party leader
  final cacheKey = 'party_$selectedParty';

  // clear cache for test purposes
  //await CacheManager().clearCache(cacheKey);

  // Try to get data from cache
  print('Trying to get data from cache');
  List<Ledamot> cachedData = await CacheManager().getCache(cacheKey);
  if (cachedData.isNotEmpty) {
    // Use cached data

    print('Using cached data');
    return cachedData;
  }

  print('No cached data. Calling api');
  // If data not in cache, make the API call
  final url = Uri.parse(
      'https://data.riksdagen.se/personlista/?iid=&fnamn=&enamn=&f_ar=&kn=&parti=$selectedParty&valkrets=&rdlstatus=tjanst&org=&utformat=json&sort=sorteringsnamn&sortorder=asc&termlista=');

  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> persons = data['personlista']['person'];

// Convert the list of persons into a list of Ledamot

      List<Ledamot> ledamotList = persons.map((person) {
        return Ledamot.fromJson(person);
      }).toList();

      // Cache the data for future use
      await CacheManager().setCache(cacheKey, ledamotList);

      return ledamotList;
    } else {
      throw Exception('Failed to load data');
    }
  } catch (error) {
    // Handle network errors or other exceptions
    print('Error: $error');

    rethrow;
  }
}

Future<List<LedamotResult>> fetchLedamotListVotes(
    // Gets a list of vote results for each ledamot for selected party, proposal, point
    selectedParty,
    beteckning,
    punkt) async {
  final url = Uri.parse(
      "https://data.riksdagen.se/voteringlista/?rm=2022%2F23&bet=$beteckning&punkt=$punkt&parti=$selectedParty&valkrets=&rost=&iid=&sz=10000&utformat=json&gruppering=");
  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      final List<dynamic> persons = data['voteringlista']['votering'];

      // Convert the list of voteringar into a list of LedamotResult
      List<LedamotResult> ledamotList = persons.map((person) {
        return LedamotResult.fromJson(person);
      }).toList();

      return ledamotList;
    } else {
      throw Exception('Failed to load data');
    }
  } catch (error) {
    // Handle network errors or other exceptions
    print('Error: $error');
    rethrow;
  }
}

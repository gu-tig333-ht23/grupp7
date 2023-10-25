import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import '../../models/model_ledamotview_votering.dart';

Future<List<voteringar>> apiGetPartiVote(rm, bet, punkt) async {
  final String url =
      'https://data.riksdagen.se/voteringlista/?rm=$rm&bet=$bet&punkt=$punkt&valkrets=&rost=&iid=&sz=5000&utformat=json&gruppering=';
  print(url);
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      List<dynamic> voteringlista = jsonData['voteringlista']['votering'];

      if (voteringlista != null && voteringlista is List) {
        List<voteringar> partiVotes =
            voteringlista.map((json) => voteringar.fromJson(json)).toList();
        return partiVotes;
      } else {
        print('voteringlista is not a List.');
        return [];
      }
    } else {
      print('Failed to get data. Error: ${response.statusCode}');
      return [];
    }
  } catch (error) {
    print('Error: $error');
    return [];
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/model_ledamot_view_votering.dart';

Future<List<voteringar>> apiGetList(iid, antal) async {
  final String url =
      'https://data.riksdagen.se/voteringlista/?rm=&bet=&punkt=&valkrets=&rost=&iid=$iid&sz=$antal&utformat=json&gruppering=';
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      List<dynamic> voteringlista = jsonData['voteringlista']['votering'];

      List<voteringar> datapoints =
          voteringlista.map((json) => voteringar.fromJson(json)).toList();
      return datapoints;
    } else {
      print('Failed to get data. Error: ${response.statusCode}');
      return [];
    }
  } catch (error) {
    print('Error: $error');
    return [];
  }
}

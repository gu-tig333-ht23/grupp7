import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../../models/model_infoview.dart';

const String endPoint =
    'https://data.riksdagen.se/voteringlista/?rm=2022%2F23&valkrets=&rost=&iid=&sz=500&utformat=json&gruppering=parti&bet=';

//const String forslagspunkt = '2'; placeholder om vi ska använda oss av förslagspunkt senare

Future<List<PartiVotering>> getVotingResult(String beteckning) async {
  final response = await http.get(Uri.parse('$endPoint$beteckning'));
  if (response.statusCode == 200) {
    String body = response.body;
    final Map<String, dynamic> jsonData = jsonDecode(body);

    if (jsonData.containsKey('voteringlista') &&
        jsonData['voteringlista'].containsKey('votering')) {
      final List<dynamic> voteringList = jsonData['voteringlista']['votering'];

      List<PartiVotering> partiVoteringList =
          voteringList.map((json) => PartiVotering.fromJson(json)).toList();

      return partiVoteringList;
    } else {
      throw Exception('Data format is incorrect');
    }
  } else {
    throw Exception('Failed to load data');
  }
}
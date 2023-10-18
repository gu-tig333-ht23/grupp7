import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const String endPoint =
    'https://data.riksdagen.se/voteringlista/?rm=2022%2F23&bet=$beteckning&punkt=$forslagspunkt&parti=C&parti=FP&parti=L&parti=KD&parti=MP&parti=M&parti=S&parti=SD&parti=V&valkrets=&rost=&iid=&sz=500&utformat=json&gruppering=bet';

const String beteckning = 'au10';
const String forslagspunkt = '1';

class AllPartiVotering {
  String yes;
  String no;
  String abscent;
  String pass;

  AllPartiVotering({
    required this.yes,
    required this.no,
    required this.abscent,
    required this.pass,
  });

  factory AllPartiVotering.fromJson(Map<String, dynamic> json) {
    return AllPartiVotering(
      yes: json['Ja'],
      no: json['Nej'],
      abscent: json['Frånvarande'],
      pass: json['Avstår'],
    );
  }
}

Future<List<AllPartiVotering>> getAllVotingResult() async {
  final response = await http.get(Uri.parse(endPoint));
  if (response.statusCode == 200) {
    String body = response.body;
    final Map<String, dynamic> jsonData = jsonDecode(body);

    if (jsonData.containsKey('voteringlista') &&
        jsonData['voteringlista'].containsKey('votering')) {
      final List<dynamic> voteringList = jsonData['voteringlista']['votering'];

      List<AllPartiVotering> partiVoteringList =
          voteringList.map((json) => AllPartiVotering.fromJson(json)).toList();

      return partiVoteringList;
    } else {
      throw Exception('Data format is incorrect');
    }
  } else {
    throw Exception('Failed to load data');
  }
}

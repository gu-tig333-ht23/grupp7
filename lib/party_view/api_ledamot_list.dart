import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Ledamot>> fetchLedamotList(selectedParty) async {
  final String party;
  final url = Uri.parse(
      'https://data.riksdagen.se/personlista/?iid=&fnamn=&enamn=&f_ar=&kn=&parti=$selectedParty&valkrets=&org=&utformat=json');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      final List<dynamic> persons = data['personlista']['person'];

      // Convert the list of persons into a list of Ledamot
      List<Ledamot> ledamotList = persons.map((person) {
        return Ledamot.fromJson(person);
      }).toList();

      return ledamotList;
    } else {
      throw Exception('Failed to load data');
    }
  } catch (error) {
    // Handle network errors or other exceptions
    print('Error: $error');
    throw error;
  }
}

//Future<Map<String, dynamic>> fetchPersonMap() async {
//  final url = Uri.parse(
//      'https://data.riksdagen.se/personlista/?iid=&fnamn=&enamn=&f_ar=&kn=&parti=&valkrets=&org=&utformat=json');
//
//  try {
//    final response = await http.get(url);
//
//    if (response.statusCode == 200) {
//      final Map<String, dynamic> data = json.decode(response.body);
//
//      // Assuming data is a map with a key "personlista" containing a list
//      final List<dynamic> persons = data['personlista']['person'];
//
//      // Convert the list of persons into a map
//      Map<String, dynamic> personMap = {};
//      persons.forEach((person) {
//        final Ledamot ledamot = Ledamot.fromJson(person);
//        personMap[ledamot.efternamn] = {
//          'tilltalsnamn': ledamot.tilltalsnamn,
//          'efternamn': ledamot.efternamn,
//          'bild_url_80': ledamot.bildUrl80,
//          'parti': ledamot.parti,
//          'intressent_id': ledamot.intressentId
//        };
//      });
//
//      return personMap;
//    } else {
//      throw Exception('Failed to load data');
//    }
//  } catch (error) {
//    // Handle network errors or other exceptions
//    print('Error: $error');
//    throw error;
//  }
//}

class Ledamot {
  final String tilltalsnamn;
  final String efternamn;
  final String bildUrl80;
  final String party;
  final String intressentId;

  Ledamot(
      {required this.tilltalsnamn,
      required this.efternamn,
      required this.bildUrl80,
      required this.party,
      required this.intressentId});

  factory Ledamot.fromJson(Map<String, dynamic> json) {
    return Ledamot(
        tilltalsnamn: json['tilltalsnamn'] ?? '',
        efternamn: json['efternamn'] ?? '',
        bildUrl80: json['bild_url_80'] ?? '',
        party: json['party'] ?? '',
        intressentId: json['intressent_id']);
  }
}

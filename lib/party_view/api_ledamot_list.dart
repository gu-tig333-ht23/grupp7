import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:template/provider/provider_infoview.dart';

Future<List<Ledamot>> fetchLedamotList(selectedParty) async {
  final String party;

  final url = Uri.parse(
      'https://data.riksdagen.se/personlista/?iid=&fnamn=&enamn=&f_ar=&kn=&parti=$selectedParty&valkrets=&rdlstatus=samtliga&org=&utformat=json&sort=sorteringsnamn&sortorder=asc&termlista=');

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

class Ledamot {
  final String tilltalsnamn;
  final String efternamn;
  final String bildUrl80;
  final String party;
  final String intressentId;
  final bool partiLedare;

  Ledamot(
      {required this.tilltalsnamn,
      required this.efternamn,
      required this.bildUrl80,
      required this.party,
      required this.intressentId,
      this.partiLedare = false});

  factory Ledamot.fromJson(Map<String, dynamic> json) {
    // Extracting the list of "uppdrag" from "personuppdrag"
    final List<dynamic> uppdragList = json['personuppdrag']['uppdrag'] ?? [];

    // Check if any "uppdrag" has "roll_kod" = "Partiledare" or "Språkrör"
    final bool isPartiLedare = uppdragList.any((uppdrag) =>
        (uppdrag['roll_kod'] == 'Partiledare' ||
            uppdrag['roll_kod'] == 'Språkrör') &&
        uppdrag['tom'] == "");

    return Ledamot(
        tilltalsnamn: json['tilltalsnamn'] ?? '',
        efternamn: json['efternamn'] ?? '',
        bildUrl80: json['bild_url_80'] ?? '',
        party: json['party'] ?? '',
        intressentId: json['intressent_id'],
        partiLedare: isPartiLedare);
  }
}

class LedamotResult {
  final String namn;
  final String party;
  final String intressentId;
  final String punkt;
  final String vote;

  LedamotResult(
      {required this.namn,
      required this.party,
      required this.intressentId,
      required this.punkt,
      required this.vote});

  factory LedamotResult.fromJson(Map<String, dynamic> json) {
    // Extracting the list of "uppdrag" from "personuppdrag"

    return LedamotResult(
        namn: json['namn'] ?? '',
        party: json['parti'] ?? '',
        intressentId: json['intressent_id'],
        punkt: json['punkt'],
        vote: json['rost']);
  }
}

Future<List<LedamotResult>> fetchLedamotListVotes(
    selectedParty, beteckning, punkt) async {
  final url = Uri.parse(
      "https://data.riksdagen.se/voteringlista/?rm=2022%2F23&bet=$beteckning&punkt=$punkt&parti=$selectedParty&valkrets=&rost=&iid=&sz=10000&utformat=json&gruppering=");
  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      final List<dynamic> persons = data['voteringlista']['votering'];

// Convert the list of persons into a list of Ledamot

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

    throw error;
  }
}

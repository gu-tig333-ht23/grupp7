import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

const String endPoint =
    'https://data.riksdagen.se/voteringlista/?rm=2022%2F23&bet=$beteckning&punkt=$forslagspunkt&valkrets=&rost=&iid=&sz=500&utformat=json&gruppering=parti';

const String beteckning = 'au5';
const String forslagspunkt = '2';

class PartiVotering {
  final String party;
  final int yes;
  final int no;
  final int abscent;
  final int pass;

  PartiVotering(
      {required this.party,
      required this.yes,
      required this.no,
      required this.abscent,
      required this.pass});

  factory PartiVotering.fromJson(Map<String, dynamic> json) {
    return PartiVotering(
      party: json['parti'],
      yes: json['JA'],
      no: json['NEJ'],
      abscent: json['Frånvarande'],
      pass: json['Avstå'],
    );
  }
}

Future<List<PartiVotering>> getVotingResult() async {
  final response = await http.get(Uri.parse('$endPoint'));
  if (response.statusCode == 200) {
    Iterable jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => PartiVotering.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load data');
  }
}









//REQUIREMENTSS
//Datum
//Beteckning
//Förslagspunkt


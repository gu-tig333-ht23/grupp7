import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

const String endPoint =
    'https://data.riksdagen.se/voteringlista/?rm=2022%2F23&bet=$beteckning&punkt=$forslagspunkt&valkrets=&rost=&iid=&sz=500&utformat=json&gruppering=parti';

const String beteckning = 'au10';
const String forslagspunkt = '1';

class PartiVotering {
  final String party;
  String yes;
  String no;
  String abscent;
  String pass;
  int? highestValue;
  String? majorityResult;
  HexColor? partyColor;
  String? partyImage;

  PartiVotering({
    required this.party,
    required this.yes,
    required this.no,
    required this.abscent,
    required this.pass,
    this.highestValue,
    this.majorityResult,
    this.partyColor,
    this.partyImage,
  });

  factory PartiVotering.fromJson(Map<String, dynamic> json) {
    return PartiVotering(
      party: json['parti'],
      yes: json['Ja'],
      no: json['Nej'],
      abscent: json['Frånvarande'],
      pass: json['Avstår'],
    );
  }
}

Future<List<PartiVotering>> getVotingResult() async {
  final response = await http.get(Uri.parse('$endPoint'));
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


//REQUIREMENTSS
//Datum
//Beteckning
//Förslagspunkt




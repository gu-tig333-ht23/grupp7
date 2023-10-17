import 'package:hexcolor/hexcolor.dart';

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
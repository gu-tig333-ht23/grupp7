import 'package:flutter/material.dart';
import 'votering_api.dart';


class MyState extends ChangeNotifier {
  //VAR
  List<PartiVotering> _partiVoteringar = [];

  //GET
  List<PartiVotering> get partiVotering => _partiVoteringar;

  //Fetch from api function.
  void fetchVotingresult() async {
    var partiVotering = await getVotingResult();
    _partiVoteringar = partiVotering;

    //Remove where party name == '-', blank non existent party in the parlament.
    _partiVoteringar.removeWhere((partiVotering) => partiVotering.party == '-');

    //Replace instance values of null to 0
    replaceNullValues();
    notifyListeners();
  }

  //Replace instance values of null to 0
  void replaceNullValues() {
    for (PartiVotering partiVotering in _partiVoteringar) {
      if (partiVotering.yes == '') {
        partiVotering.yes = '0'; // Add a semicolon here
      }
      if (partiVotering.no == '') {
        partiVotering.no = '0';
      }
      if (partiVotering.abscent == '') {
        partiVotering.abscent = '0';
      }
      if (partiVotering.pass == '') {
        partiVotering.pass = '0';
      }
    }
  }

  //Takes in a object or instance as input.
  //Returns two values 'highestVoteCount' and 'majorityResult'. The highestVoteCount variable shows the highest amount od vote for each party.
  //highestVoteCount returns 'JA', 'NEJ', 'AVSTÅR', 'FRÅNVARANDE' as in figma design. 

  Map<String, dynamic> sortVotevalues(PartiVotering partiVotering) {
  List sortList = [
    int.parse(partiVotering.yes),
    int.parse(partiVotering.no),
    int.parse(partiVotering.abscent),
    int.parse(partiVotering.pass),
  ];

  sortList.sort((a, b) => b.compareTo(a));

  // Antal röster för partiet:
  int highestVoteCount = sortList[0];

  String majorityResult = '';

  if (partiVotering.yes == highestVoteCount) {
    majorityResult = 'JA';
  } else if (partiVotering.no == highestVoteCount) {
    majorityResult = 'NEJ';
  } else if (partiVotering.abscent == highestVoteCount) {
    majorityResult = 'FRÅNVARANDE';
  } else if (partiVotering.pass == highestVoteCount) {
    majorityResult = 'AVSTÅR';
  }

  return {'highestVoteCount': highestVoteCount, 'majorityResult': majorityResult};
}


  //Print instance in list partiVoteringar
  void printPartiVotering() {
    for (PartiVotering partiVotering in _partiVoteringar) {
      print('Party: ${partiVotering.party}');
      print('Yes: ${partiVotering.yes}');
      print('No: ${partiVotering.no}');
      print('Absent: ${partiVotering.abscent}');
      print('Pass: ${partiVotering.pass}');
      print('\n');
    }
  }
}

import 'package:flutter/material.dart';
import 'votering_api.dart';
import 'theme.dart';

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

    //Idea: before, the values of highestValue and majorityResult in the api call is set as null.
    //I want to replace the highestValue and majorityResult null values with the return of sortVotevalues(PartiVotering partiVotering).
    //This will help the presentation of the partyvVote_widget.
    //For loop for all PartiVotering partiVotering in _partiVoteringar:
    //
    for (PartiVotering partiVotering in _partiVoteringar) {
      Map<String, dynamic> voteValues = sortVotevalues(partiVotering);
      partiVotering.highestValue = voteValues['highestVoteCount'];
      partiVotering.majorityResult = voteValues['majorityResult'];
    }

    for (PartiVotering partiVotering in _partiVoteringar) {
      setPartyColorAndImage(partiVotering);
    }

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

  setPartyColorAndImage(PartiVotering partiVotering) {
    switch (partiVotering.party) {
      case 'SD':
        partiVotering.partyColor = AppColors.sverigedemokraternaBlue;
        partiVotering.partyImage = AppImages.imageSverigedemokraterna;
        break;
      case 'C':
        partiVotering.partyColor = AppColors.centerpartietGreen;
        partiVotering.partyImage = AppImages.imageCenterpartiet;
        break;
      case 'KD':
        partiVotering.partyColor = AppColors.kristdemokraternaBlue;
        partiVotering.partyImage = AppImages.imageKristdemokraterna;
        break;
      case 'S':
        partiVotering.partyColor = AppColors.socialdemokraternaRed;
        partiVotering.partyImage = AppImages.imageSocialdemokraterna;
        break;
      case 'L':
        partiVotering.partyColor = AppColors.liberalernaBlue;
        partiVotering.partyImage = AppImages.imageLiberalerna;
        break;
      case 'MP':
        partiVotering.partyColor = AppColors.miljopartietGreen;
        partiVotering.partyImage = AppImages.imageMiljopartiet;
        break;
      case 'V':
        partiVotering.partyColor = AppColors.vansterpartietRed;
        partiVotering.partyImage = AppImages.imageVansterpartiet;
        break;
      case 'M':
        partiVotering.partyColor = AppColors.moderaternaBlue;
        partiVotering.partyImage = AppImages.imageModeraterna;
        break;
      default:
      // Handle the case where the party value is not recognized or return a default value.
    }
  }

  //Takes in a object or instance as input.
  //Returns two values 'highestVoteCount' and 'majorityResult'. The highestVoteCount variable shows the highest amount od vote for each party.
  //highestVoteCount returns 'JA', 'NEJ', 'AVSTÅR', 'FRÅNVARANDE' as in figma design.

  Map<String, dynamic> sortVotevalues(PartiVotering partiVotering) {
    List<int> sortList = [
      int.parse(partiVotering.yes),
      int.parse(partiVotering.no),
      int.parse(partiVotering.abscent),
      int.parse(partiVotering.pass),
    ];

    sortList.sort((a, b) => b.compareTo(a));

    // Antal röster för partiet:
    // Gestturedetect(Object object)
    // SD
    //YES
    //NO
    //Absent
    //Pass

    int highestVoteCount = sortList[0];

    String majorityResult = '';

    if (int.parse(partiVotering.yes) == highestVoteCount) {
      majorityResult = 'JA';
    } else if (int.parse(partiVotering.no) == highestVoteCount) {
      majorityResult = 'NEJ';
    } else if (int.parse(partiVotering.abscent) == highestVoteCount) {
      majorityResult = 'FRÅNVARANDE';
    } else if (int.parse(partiVotering.pass) == highestVoteCount) {
      majorityResult = 'AVSTÅR';
    }

    return {
      'highestVoteCount': highestVoteCount,
      'majorityResult': majorityResult
    };
  }

  //Print instance in list partiVoteringar
  void printPartiVotering() {
    for (PartiVotering partiVotering in _partiVoteringar) {
      print('Party: ${partiVotering.party}');
      print('Yes: ${partiVotering.yes}');
      print('No: ${partiVotering.no}');
      print('Absent: ${partiVotering.abscent}');
      print('Pass: ${partiVotering.pass}');

      print('Highestvote: ${partiVotering.highestValue}');
      print('majorityResult: ${partiVotering.majorityResult}');

      print('partyColor: ${partiVotering.partyColor}');
      print('PartyImage: ${partiVotering.partyImage}');

      print('\n');
    }
  }
}

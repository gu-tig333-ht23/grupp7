import 'package:Voteringsportalen/provider/provider_party_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../api/api_infoview/api_html_info_view.dart';
import '../api/api_infoview/api_all_votes.dart';
import '../models/model_infoview.dart';
import '../api/api_infoview/api_single_votes.dart';
import '../models/model_ledamot_view_votering.dart';
import '../api/api_infoview/api_punkt_list.dart';
import '../screens/info_view.dart';

class ProviderInfoView extends ChangeNotifier {
  //VAR
  final List<PartiVotering> _partiVoteringar = [];
  List<AllPartiVotering> _allPartiVoteringar = [];
  String _beteckning = '';
  String _title = '';
  String _summary = '';
  String _voteYear = '';
  List _punktList = ['1'];
  String _punkt = '1';
  Map _partiVoteNum = {
    '-': {
      'Ja': 0,
      'Nej': 0,
      'Avstår': 0,
      'Frånvarande': 0,
    },
    'C': {
      'Ja': 0,
      'Nej': 0,
      'Avstår': 0,
      'Frånvarande': 0,
    },
    'KD': {
      'Ja': 0,
      'Nej': 0,
      'Avstår': 0,
      'Frånvarande': 0,
    },
    'L': {
      'Ja': 0,
      'Nej': 0,
      'Avstår': 0,
      'Frånvarande': 0,
    },
    'M': {
      'Ja': 0,
      'Nej': 0,
      'Avstår': 0,
      'Frånvarande': 0,
    },
    'MP': {
      'Ja': 0,
      'Nej': 0,
      'Avstår': 0,
      'Frånvarande': 0,
    },
    'S': {
      'Ja': 0,
      'Nej': 0,
      'Avstår': 0,
      'Frånvarande': 0,
    },
    'SD': {
      'Ja': 0,
      'Nej': 0,
      'Avstår': 0,
      'Frånvarande': 0,
    },
    'V': {
      'Ja': 0,
      'Nej': 0,
      'Avstår': 0,
      'Frånvarande': 0,
    },
  };
  final Map _partiVotetotal = {
    'ja': 0.0,
    'nej': 0.0,
    'avs': 0.0,
    'fr': 0.0,
  };

  //whene home>>infoview
  toInfoview(
      {required beteckning,
      required title,
      required voteYear,
      required context,
      bool goBack = false}) async {
    fetchBeteckning(beteckning);
    fetchTitle(title);
    fetchYear(voteYear);
    fetchSummary(beteckning);
    await fetchPunktList();
    if (_punktList.isNotEmpty) {
      _punkt = _punktList[0];

      await Provider.of<ProviderPartyView>(context, listen: false)
          .setPunktTitle(voteYear, beteckning, punkt);
    } else {}
    fetchVotingresult();

    if (goBack == true) {
      int timesToPop = 2;
      for (var i = 0; i < timesToPop; i++) {
        if (Navigator.canPop(context)) {
          Navigator.of(context).pop();
        }
      }
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InfoView(),
        ),
      );
    }
  }

  //ny punkt
  nypunkt(punkt) {
    _punkt = punkt;
    fetchVotingresult();
    notifyListeners();
  }

  // String forslagspunkt = '';   Om vi vill sortera på förslagspunkter senare

  //GET
  List<PartiVotering> get partiVotering => _partiVoteringar;
  List<AllPartiVotering> get allPartiVoteringar => _allPartiVoteringar;
  String get beteckning => _beteckning;
  String get title => _title;
  String get summary => _summary;
  String get voteYear => _voteYear;
  Map get partiVoteNum => _partiVoteNum;
  Map get partiVotetotal => _partiVotetotal;
  List get punktList => _punktList;
  String get punkt => _punkt;

  void fetchSummary(selectedBeteckning) async {
    // hämtar sammanfattningen av förslaget från HTML-api
    _summary = await getSummary(voteYear, selectedBeteckning);
    notifyListeners();
  }

  void fetchTitle(selectedTitle) {
    // hämtar förslagets titel från home_view.dart
    _title = selectedTitle;
    notifyListeners();
  }

  void fetchBeteckning(String selectedBeteckning) {
    // hämtar förslagets beteckning från home_view.dart
    _beteckning = selectedBeteckning;
    notifyListeners();
  }

  void fetchYear(String selectedYear) {
    // hämtar förslagets år från home_view.dart
    _voteYear = selectedYear;
    notifyListeners();
  }

  //Fetch all party votes
  void fetchAllPartyVotes() async {
    var allPartiVoteringar = await getAllVotingResult(voteYear, beteckning);
    _allPartiVoteringar = allPartiVoteringar;

    _partiVoteringar.removeWhere((partiVotering) => partiVotering.party == '-');

    notifyListeners();
  }

  Future<void> fetchPunktList() async {
    _punktList = await apiFetchPunktList(voteYear, _beteckning);
  }

  //Fetch from api function.
  void fetchVotingresult() async {
    List<voteringar> partiVotering =
        await apiGetPartiVote(voteYear, beteckning, _punkt);
    int voteJaNum = 0;
    int voteNejNum = 0;
    int voteAvsNum = 0;
    int voteFrNum = 0;

    Map partiVoteNum = {
      '-': {
        'Ja': 0,
        'Nej': 0,
        'Avstår': 0,
        'Frånvarande': 0,
      },
      'C': {
        'Ja': 0,
        'Nej': 0,
        'Avstår': 0,
        'Frånvarande': 0,
      },
      'KD': {
        'Ja': 0,
        'Nej': 0,
        'Avstår': 0,
        'Frånvarande': 0,
      },
      'L': {
        'Ja': 0,
        'Nej': 0,
        'Avstår': 0,
        'Frånvarande': 0,
      },
      'M': {
        'Ja': 0,
        'Nej': 0,
        'Avstår': 0,
        'Frånvarande': 0,
      },
      'MP': {
        'Ja': 0,
        'Nej': 0,
        'Avstår': 0,
        'Frånvarande': 0,
      },
      'S': {
        'Ja': 0,
        'Nej': 0,
        'Avstår': 0,
        'Frånvarande': 0,
      },
      'SD': {
        'Ja': 0,
        'Nej': 0,
        'Avstår': 0,
        'Frånvarande': 0,
      },
      'V': {
        'Ja': 0,
        'Nej': 0,
        'Avstår': 0,
        'Frånvarande': 0,
      },
    };

    for (var vote in partiVotering) {
      if (vote.rost == 'Ja') {
        voteJaNum += 1;
      } else if (vote.rost == 'Nej') {
        voteNejNum += 1;
      } else if (vote.rost == 'Frånvarande') {
        voteFrNum += 1;
      } else if (vote.rost == 'Avstår') {
        voteAvsNum += 1;
      }

      partiVoteNum[vote.parti][vote.rost] += 1;
    }
    _partiVoteNum = partiVoteNum;

    _partiVotetotal['ja'] = voteJaNum.toDouble();
    _partiVotetotal['nej'] = voteNejNum.toDouble();
    _partiVotetotal['avs'] = voteAvsNum.toDouble();
    _partiVotetotal['fr'] = voteFrNum.toDouble();

    notifyListeners();
  }

  // Get instances of PartiVotering for selected party in partyview
  List<PartiVotering> getPartiVoteringForParty(selectedParty) {
    return _partiVoteringar
        .where((partiVotering) => partiVotering.party == selectedParty)
        .toList();
  }
}

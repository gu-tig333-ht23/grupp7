import 'package:flutter/material.dart';
import '../api/api_homeview/api_home_view.dart';
import '../screens/home_view.dart';

class ProviderHomeView extends ChangeNotifier {
  List<Voteringar> _voteringar = [];
  List<Voteringar> get voteringar => _voteringar;

  ProviderHomeView() {
    fetchVotes();
  }

  Voteringar fetchUtskott(Voteringar voteringar) {
    switch (voteringar.organ) {
      case 'JuU':
        voteringar.utskott = 'Justitieutskottet';
        return voteringar;
      case 'AU':
        voteringar.utskott = 'Arbetsmarknadsutskottet';
        return voteringar;
      case 'CU':
        voteringar.utskott = 'Civilutskottet';
        return voteringar;
      case 'FiU':
        voteringar.utskott = 'Finansutskottet';
        return voteringar;
      case 'UU':
        voteringar.utskott = 'Utrikesutskottet';
        return voteringar;
      case 'SoU':
        voteringar.utskott = 'Social­utskottet';
        return voteringar;
      case 'FöU':
        voteringar.utskott = 'Försvars­utskottet';
        return voteringar;
      case 'KU':
        voteringar.utskott = 'Konstitutions­utskottet';
        return voteringar;
      case 'KrU':
        voteringar.utskott = 'Kultur­utskottet';
        return voteringar;
      case 'MJU':
        voteringar.utskott = 'Miljö- och jordbruksutskottet';
        return voteringar;
      case 'NU':
        voteringar.utskott = 'Närings­utskottet';
        return voteringar;
      case 'SkU':
        voteringar.utskott = 'Skatte­utskottet';
        return voteringar;
      case 'SfU':
        voteringar.utskott = 'Socialförsäkrings­utskottet';
        return voteringar;
      case 'TU':
        voteringar.utskott = 'Trafik­utskottet';
        return voteringar;
      case 'UbU':
        voteringar.utskott = 'Utbildnings­utskottet';
        return voteringar;
      case 'EU':
        voteringar.utskott = 'EU-nämnden';
        return voteringar;
      default:
        print('Hittade inte utskottet');
        voteringar.utskott = '';
        return voteringar;
    }
  }

  void fetchVotes() async {
    List<Voteringar> voteringar = await apiGetVotes();
    List<Voteringar> uniqueVoteringar = getUniqueTiles(voteringar);
    List<Voteringar> updatedVoteringar = [];

    for (var voteringarItem in uniqueVoteringar) {
      updatedVoteringar.add(fetchUtskott(voteringarItem));
    }

    _voteringar = updatedVoteringar;
    notifyListeners();
  }

  List<Voteringar> getUniqueTiles(List<Voteringar> list) {
    Set<String> uniqueSignatures = {};
    List<Voteringar> uniqueList = [];

    for (var item in list) {
      String signature = "${item.identificationYear}-${item.beteckning}";
      if (!uniqueSignatures.contains(signature)) {
        uniqueSignatures.add(signature);
        uniqueList.add(item);
      }
    }
    return uniqueList;
  }
}

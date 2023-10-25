import 'package:flutter/material.dart';
import '../api/api_homeview/api_home_view.dart';
import '../screens/home_view.dart';
import '.././models/model_dokument.dart';

class ProviderHomeView extends ChangeNotifier {
  List<Dokument> _dokument = [];
  List<Dokument> get voteringar => _dokument;

  ProviderHomeView() {
    fetchDokuments();
  }

  Dokument fetchUtskott(Dokument dokument) {
    switch (dokument.organ) {
      case 'JuU':
        dokument.utskott = 'Justitieutskottet';
        return dokument;
      case 'AU':
        dokument.utskott = 'Arbetsmarknadsutskottet';
        return dokument;
      case 'CU':
        dokument.utskott = 'Civilutskottet';
        return dokument;
      case 'FiU':
        dokument.utskott = 'Finansutskottet';
        return dokument;
      case 'UU':
        dokument.utskott = 'Utrikesutskottet';
        return dokument;
      case 'SoU':
        dokument.utskott = 'Social­utskottet';
        return dokument;
      case 'FöU':
        dokument.utskott = 'Försvars­utskottet';
        return dokument;
      case 'KU':
        dokument.utskott = 'Konstitutions­utskottet';
        return dokument;
      case 'KrU':
        dokument.utskott = 'Kultur­utskottet';
        return dokument;
      case 'MJU':
        dokument.utskott = 'Miljö- och jordbruksutskottet';
        return dokument;
      case 'NU':
        dokument.utskott = 'Närings­utskottet';
        return dokument;
      case 'SkU':
        dokument.utskott = 'Skatte­utskottet';
        return dokument;
      case 'SfU':
        dokument.utskott = 'Socialförsäkrings­utskottet';
        return dokument;
      case 'TU':
        dokument.utskott = 'Trafik­utskottet';
        return dokument;
      case 'UbU':
        dokument.utskott = 'Utbildnings­utskottet';
        return dokument;
      case 'EU':
        dokument.utskott = 'EU-nämnden';
        return dokument;
      default:
        print('Hittade inte utskottet');
        dokument.utskott = '';
        return dokument;
    }
  }

  void fetchDokuments() async {
    List<Dokument> dokument = await apiGetDokuments();
    List<Dokument> uniqueDokument = getUniqueTiles(dokument);
    List<Dokument> updatedDokument = [];

    for (var voteringarItem in uniqueDokument) {
      updatedDokument.add(fetchUtskott(voteringarItem));
    }

    _dokument = updatedDokument;
    notifyListeners();
  }

  List<Dokument> getUniqueTiles(List<Dokument> list) {
    Set<String> uniqueSignatures = {};
    List<Dokument> uniqueList = [];

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

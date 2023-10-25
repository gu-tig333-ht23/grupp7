import 'package:flutter/material.dart';
import '../api/api_homeview/api_home_view.dart';
import '.././models/model_dokument.dart';

class ProviderHomeView extends ChangeNotifier {
  List<Dokument> _dokument = [];
  List<Dokument> get voteringar => _dokument;
  bool _aboutAppAlertShown = false;

  ProviderHomeView() {
    fetchDokuments();
  }

  get aboutAppAlertShown => _aboutAppAlertShown;

  set aboutAppAlertShown(value) {
    _aboutAppAlertShown = value;
  }

  void fetchDokuments() async {
    List<Dokument> dokument = await apiGetDokuments();
    List<Dokument> uniqueDokument = getUniqueTiles(dokument);

    _dokument = uniqueDokument;
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

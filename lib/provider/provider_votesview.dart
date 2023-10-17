import 'package:flutter/material.dart';
import '../api/api_homeview/api_home_view.dart';
import '../screens/home_view.dart';

class ProviderVoteringsVy extends ChangeNotifier {
  List<Voteringar> _voteringar = [];
  List<Voteringar> get voteringar => _voteringar;

  List<Widget> voteringsDisplay = <Widget>[
      Text('Genomförda'),
      Text('Kommande'),
  ];
  
  final List<bool> _selectedVotering = <bool>[true, false];
  List<bool> get selectedVotering => _selectedVotering;


  ProviderVoteringsVy() {
    fetchVotes();
  }

  void getSelectedVotering(index) {
    for (int i = 0; i < selectedVotering.length; i++) {
      selectedVotering[i] = i == index;}
    notifyListeners();
  }

  void fetchVotes() async {
    List<Voteringar> voteringar = await apiGetVotes();
    List<Voteringar> uniqueVoteringar = getUniqueTiles(voteringar);
    _voteringar = uniqueVoteringar;
    notifyListeners();
  }

  List<Voteringar> getUniqueTiles(List<Voteringar> list) {
    Set<String> uniqueSignatures = {};
    List<Voteringar> uniqueList = [];

    for (var item in list) {
      String signature = "${item.rm}-${item.beteckning}";
      if (!uniqueSignatures.contains(signature)) {
        uniqueSignatures.add(signature);
        uniqueList.add(item);
      }
    }
    return uniqueList;
  }
}
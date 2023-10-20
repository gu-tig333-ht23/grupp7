import 'package:template/party_view/api_ledamot_list.dart';
import 'package:flutter/material.dart';

class PartyViewState extends ChangeNotifier {
  List<Ledamot> _ledamotList = [];
  List _PieChartValues = [0, 0, 0, 0];
  String _selectedParty = 'S';

  String get selectedParty => _selectedParty;
  List get PieChartValues => _PieChartValues;

  void setSelectedParty(String selectedParty) {
    // sets selected party for party_view. updates from selection in info_view.
    _selectedParty = selectedParty;
    notifyListeners();
  }

  void setPieChartValues(yes, no, pass, abscent) {
    _PieChartValues[0] = int.parse(yes);
    _PieChartValues[1] = int.parse(no);
    _PieChartValues[2] = int.parse(pass);
    _PieChartValues[3] = int.parse(abscent);
  }

  Future<void> fetchPartyMembers(selectedParty) async {
    var ledamotList = await fetchLedamotList(selectedParty);
    _partiLedare = ledamotList.firstWhere((ledamot) => ledamot.partiLedare);
    _ledamotList = sortLedamotList(ledamotList);
    notifyListeners();
  }

  List<Ledamot> get ledamotList => _ledamotList; // Returns sorted list

  List<Ledamot> sortLedamotList(List<Ledamot> ledamotList) {
    // sort on last name
    ledamotList.sort((a, b) => a.efternamn.compareTo(b.efternamn));
    return ledamotList;
  }

  //Future<void> getPartiLedare(selectedParty) async {
  //  await fetchPartyMembers(selectedParty); // Ensure data is loaded
  //  _partiLedare = _ledamotList.firstWhere((ledamot) => ledamot.partiLedare);
  //  notifyListeners();
  //  //    orElse: () => null);
  //}

  void getLedamotListSearch(String searchTerm) {
    // Implement the logic to filter the list based on the searchTerm
    // For example, you can update the _ledamotList based on the search term
    // and then notify listeners.
    _ledamotList = _ledamotList
        .where((ledamot) =>
            ledamot.efternamn.contains(searchTerm) ||
            ledamot.tilltalsnamn.contains(searchTerm))
        .toList();

    // Notify listeners to update the UI
    notifyListeners();
  }

  Ledamot? _partiLedare;
  Ledamot? get partiLedare => _partiLedare;
}

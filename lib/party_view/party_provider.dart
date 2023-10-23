import 'package:provider/provider.dart';
import 'package:template/party_view/api_ledamot_list.dart';
import 'package:flutter/material.dart';
import 'package:template/provider/provider_infoview.dart';
import 'package:template/api/api_infoview/api_single_votes.dart';

class PartyViewState extends ChangeNotifier {
  List<Ledamot> _ledamotList = [];

  List<double> _PieChartValues = [0, 0, 0, 0];
  List<LedamotResult> _ledamotResultList = [];
  List<LedamotResult> _originalLedamotResultList = [];
  List<Ledamot> _partiLedareList = [];
  List<Ledamot> get partiLedareList => _partiLedareList;

  String _selectedParty = 'S';

  String get selectedParty => _selectedParty;
  List get PieChartValues => _PieChartValues;

  Future<void> fetchPartyMemberVotes(selectedParty, beteckning, punkt) async {
    var ledamotResultList =
        await fetchLedamotListVotes(selectedParty, beteckning, punkt);

    // Preserve the original unfiltered list
    _originalLedamotResultList = ledamotResultList;

    // Set the filtered list initially to the original list
    _ledamotResultList = _originalLedamotResultList;

    // Notify listeners to update the UI
    notifyListeners();
  }

  ProviderInfoView providerInfoView = ProviderInfoView();
  List<LedamotResult> get ledamotResultList => _ledamotResultList;
  //  .where((result) => result.punkt == providerInfoView.punkt)
  //  .toList();

  List<LedamotResult> sortLedamotResultList(
      List<LedamotResult> ledamotResultList) {
    // sort on last name
    ledamotResultList.sort();
    return ledamotResultList;
  }

  Ledamot findLedamotByIntressentId(String intressentId) {
    // returns instance of ledamot matched on iid
    return ledamotList.firstWhere(
      (ledamot) => ledamot.intressentId == intressentId,
      orElse: () => Ledamot(
          tilltalsnamn: '',
          efternamn: '',
          bildUrl80: // placeholder
              'https://www.pngjoy.com/pngm/52/1165788_female-blank-facebook-profile-picture-female-transparent-png.png',
          party: '',
          intressentId: ''),
    );
  }

  void setSelectedParty(String selectedParty) {
    // sets selected party for party_view. updates from selection in info_view.
    _selectedParty = selectedParty;
    notifyListeners();
  }

  void setPieChartValues(yes, no, pass, abscent) {
    _PieChartValues[0] = double.parse(yes);
    _PieChartValues[1] = double.parse(no);
    _PieChartValues[2] = double.parse(pass);
    _PieChartValues[3] = double.parse(abscent);
  }

  Future<void> fetchPartyMembers(selectedParty) async {
    var ledamotList = await fetchLedamotList(selectedParty);
    _partiLedare = ledamotList.firstWhere((ledamot) => ledamot.partiLedare);
    _partiLedareList =
        ledamotList.where((ledamot) => ledamot.partiLedare).toList();
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
    // Update _ledamotResultList based on the search term and then notify listeners.

    searchTerm = searchTerm.toLowerCase();

    _ledamotResultList = _originalLedamotResultList
        .where((ledamot) => ledamot.namn.toLowerCase().contains(searchTerm))
        .toList();

    // Notify listeners to update the UI
    notifyListeners();
  }

  Future<void> setPunktTitle(beteckning, punkt) async {
    String url = 'https://data.riksdagen.se/utskottsforslag/HA01${beteckning}';
    var data = await fetchTitle(url, punkt);

    _punktTitle =
        data?['rubrik'] ?? ''; // Provide a default value if 'rubrik' is null

    notifyListeners();
  }

  Ledamot? _partiLedare;
  Ledamot? get partiLedare => _partiLedare;

  String _punktTitle = '';
  String get punktTitle => _punktTitle;
}

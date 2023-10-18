import 'package:template/party_view/api_ledamot_list.dart';
import 'package:flutter/material.dart';

class PartyViewState extends ChangeNotifier {
  List<Ledamot> _ledamotList = [];

  Future<void> fetchPartyMembers(selectedParty) async {
    var ledamotList = await fetchLedamotList(selectedParty);
    _ledamotList = sortLedamotList(ledamotList);
    notifyListeners();
  }

  List<Ledamot> get ledamotList => _ledamotList; // Returns sorted list

  List<Ledamot> sortLedamotList(List<Ledamot> ledamotList) {
    // sort on last name
    ledamotList.sort((a, b) => a.efternamn.compareTo(b.efternamn));
    return ledamotList;
  }
}

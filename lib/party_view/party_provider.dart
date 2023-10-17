import 'package:provider/provider.dart';
import 'package:template/party_view/api_ledamot_list.dart';
import 'package:flutter/material.dart';

class PartyViewState extends ChangeNotifier {
  List<Ledamot> _ledamotList = [];

  List<Ledamot> get ledamotList => _ledamotList; // Add a return statement here

  Future<void> fetchPartyMembers(selectedParty) async {
    var ledamotList = await fetchLedamotList(selectedParty);
    _ledamotList = ledamotList;
    notifyListeners();
  }
}

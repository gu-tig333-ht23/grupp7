import 'package:template/past_votes_view.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'votering_api.dart';

class MyState extends ChangeNotifier {
  //VAR
  List<PartiVotering> _partiVoteringar = [];

  //GET
  List<PartiVotering> get partiVotering => _partiVoteringar;

  MyState() {
    fetchPartiVotering();
  }

  void fetchPartiVotering() async {
    var partiVotering = await getVotingResult();
    _partiVoteringar = partiVotering;

    notifyListeners();
  }
}

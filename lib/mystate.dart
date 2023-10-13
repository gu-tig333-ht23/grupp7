import 'package:template/past_votes_view.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'votering_api.dart';

class MyState extends ChangeNotifier {
  //VAR
  List<PartiVotering> _partiVoteringar = [];

  //GET
  List<PartiVotering> get partiVotering => _partiVoteringar;

  void fetchVotingresult() async {
    var votering = await getVotingResult();
    _partiVoteringar = votering;
  }
  
  
}

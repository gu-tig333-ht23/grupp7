import 'package:flutter/material.dart';
import 'package:template/info_view.dart';
import 'package:template/past_votes_view.dart';
import 'votering_api.dart';
import 'dart:async';

void main() {
  getVotingResult();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VoteringsVy(),
    );
  }
}

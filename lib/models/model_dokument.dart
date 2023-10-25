import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/provider/provider_infoview.dart';
import 'package:template/widgets/widget_vote_card.dart';
import '../provider/provider_homeview.dart';

class Dokument extends StatelessWidget {
  final String identificationYear;
  final String beteckning;
  final String title;
  final String decisionDate;
  final String organ;
  String utskott;
  final int index;

  Dokument({
    super.key,
    this.identificationYear = '',
    required this.beteckning,
    required this.title,
    required this.decisionDate,
    required this.organ,
    this.utskott = '',
    this.index = 0,
  });

  factory Dokument.fromJson(Map<String, dynamic> json) {
    return Dokument(
        identificationYear: json['rm'],
        beteckning: json['beteckning'],
        title: json['undertitel'],
        decisionDate: json['datum'],
        organ: json['organ']);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Dokument selectedVote =
            context.read<ProviderHomeView>().voteringar[index];
        String selectedBeteckning = selectedVote.beteckning;
        String selectedTitle = selectedVote.title;
        context.read<ProviderInfoView>().toInfoview(
            beteckning: selectedBeteckning,
            title: selectedTitle,
            context: context);
      },
      child: voteCard(context, utskott, decisionDate, title, beteckning),
    );
  }
}

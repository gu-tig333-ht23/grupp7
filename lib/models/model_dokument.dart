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
  final String utskott;
  final int index;

  Dokument({
    super.key,
    this.identificationYear = '',
    required this.beteckning,
    required this.title,
    required this.decisionDate,
    required this.organ,
    this.index = 0,
  }) : utskott = calculateUtskott(organ);

  factory Dokument.fromJson(Map<String, dynamic> json) {
    return Dokument(
      identificationYear: json['rm'],
      beteckning: json['beteckning'],
      title: json['undertitel'],
      decisionDate: json['datum'],
      organ: json['organ'],
    );
  }

  static String calculateUtskott(String organ) {
    switch (organ) {
      case 'JuU':
        return 'Justitieutskottet';
      case 'AU':
        return 'Arbetsmarknadsutskottet';
      case 'CU':
        return 'Civilutskottet';
      case 'FiU':
        return 'Finansutskottet';
      case 'UU':
        return 'Utrikesutskottet';
      case 'SoU':
        return 'Social­utskottet';
      case 'FöU':
        return 'Försvars­utskottet';
      case 'KU':
        return 'Konstitutions­utskottet';
      case 'KrU':
        return 'Kultur­utskottet';
      case 'MJU':
        return 'Miljö- och jordbruksutskottet';
      case 'NU':
        return 'Närings­utskottet';
      case 'SkU':
        return 'Skatte­utskottet';
      case 'SfU':
        return 'Socialförsäkrings­utskottet';
      case 'TU':
        return 'Trafik­utskottet';
      case 'UbU':
        return 'Utbildnings­utskottet';
      case 'EU':
        return 'EU-nämnden';
      default:
        print('Hittade inte utskottet');
        return '';
    }
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
              context: context,
            );
      },
      child: voteCard(context, utskott, decisionDate, title, beteckning),
    );
  }
}

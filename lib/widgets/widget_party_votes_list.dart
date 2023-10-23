import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/theme.dart';

import '../provider/provider_infoview.dart';
import 'widget_partycard.dart';

class PartyVotesListWidget extends StatelessWidget {
  final Map<String, Color> partyColors = {
    'S': AppColors.socialdemokraternaRed,
    'M': AppColors.moderaternaBlue,
    'SD': AppColors.sverigedemokraternaBlue,
    'C': AppColors.centerpartietGreen,
    'V': AppColors.sverigedemokraternaBlue,
    'MP': AppColors.miljopartietGreen,
    'KD': AppColors.kristdemokraternaBlue,
    'L': AppColors.liberalernaBlue,
  };

  final Map<String, String> partyImages = {
    'S': 'assets/images/socialdemokraterna.png',
    'M': 'assets/images/moderaterna.png',
    'SD': 'assets/images/sverigedemokraterna.png',
    'C': 'assets/images/centerpartiet_white.png',
    'V': 'assets/images/vansterpartiet.png',
    'MP': 'assets/images/miljopartiet.png',
    'KD': 'assets/images/sverigedemokraterna.png',
    'L': 'assets/images/liberalerna.webp',
  };

  String getPartyImage(String party) =>
      partyImages[party] ?? 'assets/images/default.png';

  Color getPartyColor(String party) => partyColors[party] ?? Colors.black;

  @override
  Widget build(BuildContext context) {
    final parties = ['S', 'M', 'SD', 'C', 'V', 'MP', 'KD', 'L'];

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: parties.length,
      itemBuilder: (context, index) {
        final party = parties[index];
        final partiVoteNum =
            context.read<ProviderInfoView>().partiVoteNum[party];

        return PartyVotes(
          parti: party,
          antalJa: partiVoteNum['Ja'].toString(),
          antalNej: partiVoteNum['Nej'].toString(),
          antalAvs: partiVoteNum['Avstår'].toString(),
          antalFr: partiVoteNum['Frånvarande'].toString(),
          partiColor: getPartyColor(party),
          partyImage: getPartyImage(party),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/theme/theme.dart';

import '../provider/provider_info_view.dart';
import 'widget_partycard.dart';

class PartyVotesListWidget extends StatelessWidget {
  final Map<String, Color> partyColors = {
    'S': AppColors.socialdemokraternaRed,
    'M': AppColors.moderaternaBlue,
    'SD': AppColors.sverigedemokraternaBlue,
    'C': AppColors.centerpartietGreen,
    'V': AppColors.vansterpartietRed,
    'MP': AppColors.miljopartietGreen,
    'KD': AppColors.kristdemokraternaBlue,
    'L': AppColors.liberalernaBlue,
  };

  final Map<String, String> partyImages = {
    'S': AppImages.imageSocialdemokraterna,
    'M': AppImages.imageModeraterna,
    'SD': AppImages.imageSverigedemokraterna,
    'C': AppImages.imageCenterpartietWhite,
    'V': AppImages.imageVansterpartiet,
    'MP': AppImages.imageMiljopartiet,
    'KD': AppImages.imageKristdemokraterna,
    'L': AppImages.imageLiberalerna,
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

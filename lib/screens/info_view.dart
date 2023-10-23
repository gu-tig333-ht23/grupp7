import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/theme.dart';
import '../widgets/widget_votesummary.dart';
import '../models/model_infoview.dart';
import '../widgets/widget_voteresult_piechart.dart';
import '../widgets/widget_partycard.dart';
import '../provider/provider_infoview.dart';

class InfoView extends StatelessWidget {
  InfoView({super.key});

  //party
  //highest count
  //majorityresult

  @override
  Widget build(BuildContext context) {
    List<PartiVotering> partiVoteringar =
        context.watch<ProviderInfoView>().partiVotering;
    final List buttonList = context.watch<ProviderInfoView>().punktList;
    String aktuellPunkt = context.watch<ProviderInfoView>().punkt;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'InfoView',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InfoCard(),
            VoteResult(
              titel: 'TBA',
              ja: context.read<ProviderInfoView>().partiVotetotal['ja'],
              nej: context.read<ProviderInfoView>().partiVotetotal['nej'],
              avstar: context.read<ProviderInfoView>().partiVotetotal['avs'],
              franvarande:
                  context.read<ProviderInfoView>().partiVotetotal['fr'],
            ),
            Text('Voterings punkter'),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, // center the buttons horizontally
              children: buttonList.map((buttonLabel) {
                String punkt = context.read<ProviderInfoView>().punkt;
                Color color = AppColors.lightGrey;
                if (buttonLabel == punkt) {
                  color = AppColors.darkGrey;
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4.0), // some spacing between buttons
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<ProviderInfoView>().nypunkt(buttonLabel);
                    },
                    child: Text(buttonLabel),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(color),
                    ),
                  ),
                );
              }).toList(),
            ),
            Text('Resultet för punkt $aktuellPunkt'),
            PartyVotes(
                parti: 'S',
                antalJa: context
                    .read<ProviderInfoView>()
                    .partiVoteNum['S']['Ja']
                    .toString(),
                antalNej: context
                    .read<ProviderInfoView>()
                    .partiVoteNum['S']['Nej']
                    .toString(),
                antalAvs: context
                    .read<ProviderInfoView>()
                    .partiVoteNum['S']['Avstår']
                    .toString(),
                antalFr: context
                    .read<ProviderInfoView>()
                    .partiVoteNum['S']['Frånvarande']
                    .toString(),
                partiColor: AppColors.socialdemokraternaRed,
                partyImage: 'assets/images/socialdemokraterna.png'),
            PartyVotes(
                parti: 'M',
                antalJa: context
                    .read<ProviderInfoView>()
                    .partiVoteNum['M']['Ja']
                    .toString(),
                antalNej: context
                    .read<ProviderInfoView>()
                    .partiVoteNum['M']['Nej']
                    .toString(),
                antalAvs: context
                    .read<ProviderInfoView>()
                    .partiVoteNum['M']['Avstår']
                    .toString(),
                antalFr: context
                    .read<ProviderInfoView>()
                    .partiVoteNum['M']['Frånvarande']
                    .toString(),
                partiColor: AppColors.moderaternaBlue,
                partyImage: 'assets/images/moderaterna.png'),
            PartyVotes(
                parti: 'SD',
                antalJa: context
                    .read<ProviderInfoView>()
                    .partiVoteNum['SD']['Ja']
                    .toString(),
                antalNej: context
                    .read<ProviderInfoView>()
                    .partiVoteNum['SD']['Nej']
                    .toString(),
                antalAvs: context
                    .read<ProviderInfoView>()
                    .partiVoteNum['SD']['Avstår']
                    .toString(),
                antalFr: context
                    .read<ProviderInfoView>()
                    .partiVoteNum['SD']['Frånvarande']
                    .toString(),
                partiColor: AppColors.sverigedemokraternaBlue,
                partyImage: 'assets/images/sverigedemokraterna.png'),
            PartyVotes(
                parti: 'C',
                antalJa: context
                    .read<ProviderInfoView>()
                    .partiVoteNum['C']['Ja']
                    .toString(),
                antalNej: context
                    .read<ProviderInfoView>()
                    .partiVoteNum['C']['Nej']
                    .toString(),
                antalAvs: context
                    .read<ProviderInfoView>()
                    .partiVoteNum['C']['Avstår']
                    .toString(),
                antalFr: context
                    .read<ProviderInfoView>()
                    .partiVoteNum['C']['Frånvarande']
                    .toString(),
                partiColor: AppColors.centerpartietGreen,
                partyImage: 'assets/images/centerpartiet_white.png'),
            PartyVotes(
                parti: 'V',
                antalJa: context
                    .read<ProviderInfoView>()
                    .partiVoteNum['V']['Ja']
                    .toString(),
                antalNej: context
                    .read<ProviderInfoView>()
                    .partiVoteNum['V']['Nej']
                    .toString(),
                antalAvs: context
                    .read<ProviderInfoView>()
                    .partiVoteNum['V']['Avstår']
                    .toString(),
                antalFr: context
                    .read<ProviderInfoView>()
                    .partiVoteNum['V']['Frånvarande']
                    .toString(),
                partiColor: AppColors.sverigedemokraternaBlue,
                partyImage: 'assets/images/vansterpartiet.png'),
            PartyVotes(
                parti: 'MP',
                antalJa: context
                    .read<ProviderInfoView>()
                    .partiVoteNum['MP']['Ja']
                    .toString(),
                antalNej: context
                    .read<ProviderInfoView>()
                    .partiVoteNum['MP']['Nej']
                    .toString(),
                antalAvs: context
                    .read<ProviderInfoView>()
                    .partiVoteNum['MP']['Avstår']
                    .toString(),
                antalFr: context
                    .read<ProviderInfoView>()
                    .partiVoteNum['MP']['Frånvarande']
                    .toString(),
                partiColor: AppColors.miljopartietGreen,
                partyImage: 'assets/images/miljopartiet.png'),
            PartyVotes(
                parti: 'KD',
                antalJa: context
                    .read<ProviderInfoView>()
                    .partiVoteNum['KD']['Ja']
                    .toString(),
                antalNej: context
                    .read<ProviderInfoView>()
                    .partiVoteNum['KD']['Nej']
                    .toString(),
                antalAvs: context
                    .read<ProviderInfoView>()
                    .partiVoteNum['KD']['Avstår']
                    .toString(),
                antalFr: context
                    .read<ProviderInfoView>()
                    .partiVoteNum['KD']['Frånvarande']
                    .toString(),
                partiColor: AppColors.kristdemokraternaBlue,
                partyImage: 'assets/images/sverigedemokraterna.png'),
            PartyVotes(
                parti: 'L',
                antalJa: context
                    .read<ProviderInfoView>()
                    .partiVoteNum['L']['Ja']
                    .toString(),
                antalNej: context
                    .read<ProviderInfoView>()
                    .partiVoteNum['L']['Nej']
                    .toString(),
                antalAvs: context
                    .read<ProviderInfoView>()
                    .partiVoteNum['L']['Avstår']
                    .toString(),
                antalFr: context
                    .read<ProviderInfoView>()
                    .partiVoteNum['L']['Frånvarande']
                    .toString(),
                partiColor: AppColors.liberalernaBlue,
                partyImage: 'assets/images/liberalerna.webp'),
          ],
        ),
      ),
    );
  }
}

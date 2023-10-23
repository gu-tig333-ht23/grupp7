import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/theme.dart';
import '../widgets/widget_votesummary.dart';
import '../models/model_infoview.dart';
import '../widgets/widget_voteresult_piechart.dart';
import '../widgets/widget_partycard.dart';
import '../provider/provider_infoview.dart';
import '.././widgets/widget_party_votes_list.dart';

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
            PartyVotesListWidget(),
          ],
        ),
      ),
    );
  }
}

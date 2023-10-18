import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
            VoteResult(),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: partiVoteringar.length,
              itemBuilder: (context, index) {
                final partiVotering = partiVoteringar[index];
                return PartyVotes(partiVotering);
              },
            ),
          ],
        ),
      ),
    );
  }
}

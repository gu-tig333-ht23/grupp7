import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/votering_api.dart';
import 'infocard_widget.dart';
import 'infovy_model.dart';
import 'voteresult_piechart_widget.dart';
import 'partyvotes_widget.dart';
import 'infovy_state.dart';

class InfoView extends StatelessWidget {
  InfoView({super.key});

  //party
  //highest count
  //majorityresult

  @override
  Widget build(BuildContext context) {
    List<PartiVotering> partiVoteringar =
        context.watch<MyState>().partiVotering;

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
            FloatingActionButton(
              onPressed: () {
                context.read<MyState>().fetchVotingresult();
                context.read<MyState>().printPartiVotering();
              },
            ),
          ],
        ),
      ),
    );
  }
}

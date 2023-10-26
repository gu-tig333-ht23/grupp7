import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/theme.dart';
import '../provider/provider_party_view.dart';
import '../widgets/widget_votesummary.dart';
import '../widgets/widget_voteresult_piechart.dart';
import '../widgets/widget_party_votes_list.dart';
import '../provider/provider_info_view.dart';

class InfoView extends StatelessWidget {
  InfoView({super.key});

  //party
  //highest count
  //majorityresult

  @override
  Widget build(BuildContext context) {
    final List buttonList = context.watch<ProviderInfoView>().punktList;
    String aktuellPunkt = context.watch<ProviderInfoView>().punkt;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Information om votering',
          style: TextStyle(color: AppColors.black),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InfoCard(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 45,
                  height: 45,
                ),
                Text('Voterings punkter'),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Vad är voteringspunkter i riksdagen?'),
                          content: SingleChildScrollView(
                            child: Text(
                              'En "voteringspunkt" i riksdagen representerar ett specifikt ärende som kräver ett formellt beslut från dess ledamöter. Dessa ärenden kan vara varierande och inkluderar lagförslag, motioner, propositioner och andra viktiga frågor som måste avgöras. Riksdagens medlemmar röstar för att antingen godkänna eller avvisa dessa ärenden.\n\n'
                              'Voteringspunkter tas upp i riksdagens sammanträden när det finns oenighet, diskussion eller behov av att ta ett officiellt ställningstagande. Ärenden som är särskilt kontroversiella eller av stor allmän eller politisk betydelse prioriteras för att bli voteringspunkter. Detta är nödvändigt eftersom riksdagen hanterar en bred mängd ärenden, och att rösta om varje enskilt ärende skulle vara tidskrävande.',
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Stäng'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.info),
                ),
              ],
            ),
            Wrap(
              alignment:
                  WrapAlignment.center, // center the buttons horizontally
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
                    onPressed: () async {
                      context.read<ProviderInfoView>().nypunkt(buttonLabel);
                      var beteckning =
                          context.read<ProviderInfoView>().beteckning;
                      await context
                          .read<ProviderPartyView>()
                          .setPunktTitle(beteckning, buttonLabel);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(color),
                    ),
                    child: Text(buttonLabel),
                  ),
                );
              }).toList(),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: VoteResult(
                    titleSize: 18,
                    titel:
                        'Voteringspunkt $aktuellPunkt: ${context.watch<ProviderPartyView>().punktTitle}',
                    ja: context.read<ProviderInfoView>().partiVotetotal['ja'],
                    nej: context.read<ProviderInfoView>().partiVotetotal['nej'],
                    avstar:
                        context.read<ProviderInfoView>().partiVotetotal['avs'],
                    franvarande:
                        context.read<ProviderInfoView>().partiVotetotal['fr'],
                  ),
                ),
              ],
            ),
            PartyVotesListWidget(),
          ],
        ),
      ),
    );
  }
}

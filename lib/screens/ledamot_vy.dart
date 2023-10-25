import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/theme/theme.dart';
import '../models/model_ledamotview_votering.dart';
import '../provider/provider_ledamot.dart';
import '../widgets/widget_voterings_card.dart';
import '../widgets/widget_ledamot_vy_info.dart';
import '../widgets/widget_voteresult_piechart.dart';
import '../models/model_ledarmot_info.dart';
import '../widgets/widget_ledamot_app_bar.dart';
import '../widgets/widget_loadscreen.dart';

class LedamotVy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<voteringar> theList = context.watch<ProviderLedamot>().theList;

    Future<List<voteringar>> fetchData() async {
      final List<voteringar> data =
          await context.read<ProviderLedamot>().getList();
      context.read<ProviderLedamot>().setStat(data);
      await context.read<ProviderLedamot>().getLedarmot();
      return data;
    }

    return FutureBuilder<List<voteringar>>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loadscreen();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No data available.');
        } else {
          LedamotInfo ledamot = context.read<ProviderLedamot>().ledamotInfo;
          return Scaffold(
            appBar: LedamortAppBar(ledamot: ledamot),
            body: ListView.builder(
              itemCount: snapshot.data!.length + 3,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return LedamotVyInfo(
                    ledamot: ledamot,
                  );
                } else if (index == 1) {
                  return VoteResult(
                    titel: 'Historiska röster',
                    ja: context.watch<ProviderLedamot>().antalJa,
                    nej: context.watch<ProviderLedamot>().antalNej,
                    avstar: context.watch<ProviderLedamot>().antalAvstar,
                    franvarande:
                        context.watch<ProviderLedamot>().antalFranvarande,
                  );
                } else if (index == 2) {
                  return Center(
                      child: Text(
                    '\nTidigare röster på förslagspunkter\n',
                    style: TextStyle(fontSize: 18),
                  ));
                }

                int adjustedIndex = index - 3;

                String rawDatum = snapshot.data![adjustedIndex].systemdatum;
                String datum = (rawDatum != null && rawDatum.length >= 10)
                    ? rawDatum.substring(0, 10)
                    : rawDatum;

                return FutureBuilder<voteringar>(
                  future: context
                      .read<ProviderLedamot>()
                      .setTitle(snapshot.data![adjustedIndex]),
                  builder: (context, cardSnapshot) {
                    if (cardSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Voteringar(
                        identification: '',
                        title: '',
                        subTitle: '',
                        decisionDate: '',
                        isAccepted: '',
                      );
                    } else if (cardSnapshot.hasError) {
                      return Text('Error: ${cardSnapshot.error}');
                    } else if (!cardSnapshot.hasData ||
                        cardSnapshot.data == null) {
                      return Text(
                          'No additional data available for this card.');
                    } else {
                      return Voteringar(
                        identification:
                            snapshot.data![adjustedIndex].beteckning,
                        title: snapshot.data![adjustedIndex].titel,
                        subTitle: snapshot.data![adjustedIndex].underTitel,
                        decisionDate: datum,
                        isAccepted: snapshot.data![adjustedIndex].rost,
                      );
                    }
                  },
                );
              },
            ),
          );
        }
      },
    );
  }
}

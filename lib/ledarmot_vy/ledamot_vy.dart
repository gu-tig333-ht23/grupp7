import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../api/api_votering.dart';
import '../class_votering.dart';
import '../provider/provider_ledamot.dart';
import '../voterings_card.dart';
import './ledamot_vy_info.dart';
import 'ledarmot_vy_stat_bar.dart';

class LedamotVy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<voteringar> theList = context.watch<ProviderLedamot>().theList;

    Future<List<voteringar>> fetchData() async {
      final List<voteringar> data =
          await context.read<ProviderLedamot>().getList();
      return data;
    }

    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder<List<voteringar>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Display a loading indicator while data is fetched.
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('No data available.');
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length + 2,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return LedamotVyInfo();
                  } else if (index == 1) {
                    return LedamotVyStatBar(
                        theList: context.watch<ProviderLedamot>().theList);
                  }
                  int adjustedIndex = index - 2;

                  String rawDatum = '2020-20-20 00 00';
                  String datum = (rawDatum != null && rawDatum.length >= 10)
                      ? rawDatum.substring(0, 10)
                      : rawDatum;

                  return Voteringar(
                      identification: snapshot.data![index - 2].beteckning +
                          ' ' +
                          snapshot.data![index - 2].titel,
                      title: snapshot.data![index - 2].underTitel,
                      decisionDate: datum,
                      isAccepted: snapshot.data![adjustedIndex].rost);
                },
              );
            }
          },
        ));
  }
}

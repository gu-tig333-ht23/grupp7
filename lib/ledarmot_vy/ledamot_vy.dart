import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ledarmot_vy_stat_bar.dart';
import '../provider/provider_ledamot.dart';
import './ledamot_vy_info.dart';
import './ledamot_vy_rost_lista.dart';

class LedamotVy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          LedamotVyInfo(),
          LedamotVyStatBar(theList: context.watch<ProviderLedamot>().theList),
          LedamotVyRostLista(),
        ],
      ),
    );
  }
}

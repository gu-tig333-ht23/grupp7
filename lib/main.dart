import 'package:flutter/material.dart';
import 'package:template/info_view.dart';
import 'package:template/party_view/party_provider.dart';
import 'package:template/party_view/party_view.dart';
import './provider/provider_ledamot.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProviderLedamot()),
        ChangeNotifierProvider(create: (context) => PartyViewState()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PartyView(
        selectedParty: "S",
      ),
    );
  }
}

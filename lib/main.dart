import 'package:flutter/material.dart';
import 'package:template/party_view/party_provider.dart';
import 'package:template/party_view/party_view.dart';
import 'package:provider/provider.dart';
import 'package:template/provider/provider_infoview.dart';
import 'package:template/screens/info_view.dart';
import './provider/provider_ledamot.dart';
import 'provider/provider_votesview.dart';
import 'screens/home_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PartyViewState(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProviderLedamot(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProviderVoteringsVy(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProviderInfoView(),
        ),
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
      home: VoteringsVy(),
    );
  }
}

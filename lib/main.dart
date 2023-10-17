import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/provider/provider_infoview.dart';
import './provider/provider_ledamot.dart';
import 'provider/provider_votesview.dart';
import 'screens/home_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
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
      title: 'API test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: VoteringsVy(),
    );
  }
}

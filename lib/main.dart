import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ledarmot_vy/ledamot_vy.dart';
import './provider/provider_ledamot.dart';
import './provider/provider_voteringsvy.dart';

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
      home: LedamotVy(),
    );
  }
}
